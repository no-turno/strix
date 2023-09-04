import { BunFile } from "bun";

 const loadIndexPage = (dir: string) => Bun.file(dir);
 const returnPageResponse = (file: BunFile) => new Response(file);

 export const loaders = {
    loadIndexPage,
    returnPageResponse
 }