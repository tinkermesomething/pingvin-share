import type * as Preset from "@docusaurus/preset-classic";
import type { Config } from "@docusaurus/types";
import { themes as prismThemes } from "prism-react-renderer";

const config: Config = {
  title: "Tinkerme Share",
  tagline:
    "Tinkerme Share is a self-hosted file sharing platform and an alternative for WeTransfer. Fork of the original Pingvin Share by stonith404.",
  favicon: "img/tinkermeshare.svg",

  url: "https://tinkermesomething.github.io",
  baseUrl: "/tinkerme-share/",
  organizationName: "tinkermesomething",
  projectName: "tinkerme-share",

  onBrokenLinks: "warn",
  onBrokenMarkdownLinks: "warn",

  i18n: {
    defaultLocale: "en",
    locales: ["en"],
  },

  presets: [
    [
      "classic",
      {
        docs: {
          routeBasePath: "/",
          sidebarPath: "./sidebars.ts",
          editUrl: "https://github.com/tinkermesomething/tinkerme-share/edit/main/docs",
        },
        blog: false,
      } satisfies Preset.Options,
    ],
  ],

  themeConfig: {
    image: "img/tinkermeshare.svg",
    colorMode: {
      respectPrefersColorScheme: true,
    },
    navbar: {
      title: "Tinkerme Share",
      logo: {
        alt: "Tinkerme Share Logo",
        src: "img/tinkermeshare.svg",
      },
      items: [
        {
          href: "https://github.com/tinkermesomething/tinkerme-share",
          label: "GitHub",
          position: "right",
        },
      ],
    },
    prism: {
      theme: prismThemes.github,
      darkTheme: prismThemes.dracula,
    },
  } satisfies Preset.ThemeConfig,
};

export default config;
