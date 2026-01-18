import { BadRequestException } from "@nestjs/common";
import { sanitizeFileName } from "./file.service";

describe("sanitizeFileName", () => {
  describe("valid file names", () => {
    it("returns simple file names unchanged", () => {
      expect(sanitizeFileName("document.pdf")).toBe("document.pdf");
      expect(sanitizeFileName("image.png")).toBe("image.png");
      expect(sanitizeFileName("file")).toBe("file");
    });

    it("allows spaces and common characters", () => {
      expect(sanitizeFileName("my document.pdf")).toBe("my document.pdf");
      expect(sanitizeFileName("file-name_v2.txt")).toBe("file-name_v2.txt");
    });

    it("allows unicode characters", () => {
      expect(sanitizeFileName("文档.pdf")).toBe("文档.pdf");
      expect(sanitizeFileName("документ.txt")).toBe("документ.txt");
    });
  });

  describe("path traversal attacks", () => {
    it("strips Unix-style directory traversal", () => {
      expect(sanitizeFileName("../../../etc/passwd")).toBe("passwd");
      expect(sanitizeFileName("/etc/passwd")).toBe("passwd");
      expect(sanitizeFileName("./file.txt")).toBe("file.txt");
      expect(sanitizeFileName("foo/bar/baz.txt")).toBe("baz.txt");
    });

    it("strips Windows-style directory traversal", () => {
      expect(sanitizeFileName("..\\..\\..\\windows\\system32\\config")).toBe("config");
      expect(sanitizeFileName("C:\\Users\\Admin\\file.txt")).toBe("file.txt");
      expect(sanitizeFileName(".\\file.txt")).toBe("file.txt");
      expect(sanitizeFileName("foo\\bar\\baz.txt")).toBe("baz.txt");
    });

    it("handles mixed path separators", () => {
      expect(sanitizeFileName("../foo\\bar/baz\\file.txt")).toBe("file.txt");
      expect(sanitizeFileName("..\\../..\\../etc/passwd")).toBe("passwd");
    });
  });

  describe("null byte injection", () => {
    it("removes null bytes", () => {
      expect(sanitizeFileName("file\x00.txt")).toBe("file.txt");
      expect(sanitizeFileName("file.txt\x00.exe")).toBe("file.txt.exe");
      expect(sanitizeFileName("\x00\x00file.txt")).toBe("file.txt");
    });

    it("handles null bytes combined with path traversal", () => {
      expect(sanitizeFileName("../\x00../file.txt")).toBe("file.txt");
    });
  });

  describe("invalid inputs", () => {
    it("rejects empty strings", () => {
      expect(() => sanitizeFileName("")).toThrow(BadRequestException);
    });

    it("rejects null and undefined", () => {
      expect(() => sanitizeFileName(null as unknown as string)).toThrow(BadRequestException);
      expect(() => sanitizeFileName(undefined as unknown as string)).toThrow(BadRequestException);
    });

    it("rejects paths that resolve to nothing", () => {
      expect(() => sanitizeFileName("../")).toThrow(BadRequestException);
      expect(() => sanitizeFileName("/")).toThrow(BadRequestException);
      expect(() => sanitizeFileName("..")).toThrow(BadRequestException);
      expect(() => sanitizeFileName(".")).toThrow(BadRequestException);
    });

    it("rejects non-string inputs", () => {
      expect(() => sanitizeFileName(123 as unknown as string)).toThrow(BadRequestException);
      expect(() => sanitizeFileName({} as unknown as string)).toThrow(BadRequestException);
    });
  });

  describe("length limits", () => {
    it("truncates names longer than 255 characters", () => {
      const longName = "a".repeat(300) + ".txt";
      const result = sanitizeFileName(longName);
      expect(result.length).toBe(255);
      expect(result.endsWith(".txt")).toBe(true);
    });

    it("truncates names without extension", () => {
      const longName = "a".repeat(300);
      const result = sanitizeFileName(longName);
      expect(result.length).toBe(255);
    });

    it("handles edge case where extension is very long", () => {
      const longExt = "a".repeat(10) + "." + "b".repeat(250);
      const result = sanitizeFileName(longExt);
      expect(result.length).toBe(255);
    });
  });
});
