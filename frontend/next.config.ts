import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  output: "export",
  distDir: process.env.NEXT_OUTPUT_DIR || "../static",
};

export default nextConfig;
