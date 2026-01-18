import { BadRequestException, Injectable } from "@nestjs/common";
import { LocalFileService } from "./local.service";
import { S3FileService } from "./s3.service";
import { ConfigService } from "src/config/config.service";
import { Readable } from "stream";
import { PrismaService } from "../prisma/prisma.service";

/**
 * Sanitizes a file name to prevent path traversal and other attacks.
 * - Strips directory components (../, /, \) - handles both Unix and Windows paths
 * - Removes null bytes
 * - Limits length to 255 characters
 */
export function sanitizeFileName(name: string): string {
  if (!name || typeof name !== "string") {
    throw new BadRequestException("Invalid file name");
  }

  // Remove null bytes
  let sanitized = name.replace(/\0/g, "");

  // Normalize backslashes to forward slashes for consistent handling
  // This ensures Windows-style paths are handled correctly on Linux
  sanitized = sanitized.replace(/\\/g, "/");

  // Extract just the filename, stripping all directory components
  const lastSlash = sanitized.lastIndexOf("/");
  if (lastSlash !== -1) {
    sanitized = sanitized.substring(lastSlash + 1);
  }

  // Reject if empty or just dots (current/parent directory references)
  if (!sanitized || sanitized === "." || sanitized === "..") {
    throw new BadRequestException("Invalid file name");
  }

  // Limit length while preserving extension
  if (sanitized.length > 255) {
    const lastDot = sanitized.lastIndexOf(".");
    if (lastDot > 0) {
      const ext = sanitized.substring(lastDot);
      const base = sanitized.substring(0, lastDot);
      sanitized = base.substring(0, 255 - ext.length) + ext;
    } else {
      sanitized = sanitized.substring(0, 255);
    }
  }

  return sanitized;
}

@Injectable()
export class FileService {
  constructor(
    private prisma: PrismaService,
    private localFileService: LocalFileService,
    private s3FileService: S3FileService,
    private configService: ConfigService,
  ) {}

  // Determine which service to use based on the current config value
  // shareId is optional -> can be used to overwrite a storage provider
  private getStorageService(
    storageProvider?: string,
  ): S3FileService | LocalFileService {
    if (storageProvider != undefined)
      return storageProvider == "S3"
        ? this.s3FileService
        : this.localFileService;
    return this.configService.get("s3.enabled")
      ? this.s3FileService
      : this.localFileService;
  }

  async create(
    data: string,
    chunk: { index: number; total: number },
    file: {
      id?: string;
      name: string;
    },
    shareId: string,
  ) {
    const storageService = this.getStorageService();
    const sanitizedFile = {
      ...file,
      name: sanitizeFileName(file.name),
    };
    return storageService.create(data, chunk, sanitizedFile, shareId);
  }

  async get(shareId: string, fileId: string): Promise<File> {
    const share = await this.prisma.share.findFirst({
      where: { id: shareId },
    });
    const storageService = this.getStorageService(share.storageProvider);
    return storageService.get(shareId, fileId);
  }

  async remove(shareId: string, fileId: string) {
    const storageService = this.getStorageService();
    return storageService.remove(shareId, fileId);
  }

  async deleteAllFiles(shareId: string) {
    const storageService = this.getStorageService();
    return storageService.deleteAllFiles(shareId);
  }

  async getZip(shareId: string): Promise<Readable> {
    const storageService = this.getStorageService();
    return await storageService.getZip(shareId);
  }

  private async streamToUint8Array(stream: Readable): Promise<Uint8Array> {
    const chunks: Buffer[] = [];

    return new Promise((resolve, reject) => {
      stream.on("data", (chunk) => chunks.push(Buffer.from(chunk)));
      stream.on("end", () => resolve(new Uint8Array(Buffer.concat(chunks))));
      stream.on("error", reject);
    });
  }
}

export interface File {
  metaData: {
    id: string;
    size: string;
    createdAt: Date;
    mimeType: string | false;
    name: string;
    shareId: string;
  };
  file: Readable;
}
