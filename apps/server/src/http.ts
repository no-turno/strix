import { Router } from '@stricjs/router';
import { group } from '@stricjs/utils';
import { BunFile } from 'bun';
const pagesPublicDir = {baseURL: () => import.meta.dir + "/public", match(path: string) {
    return this.baseURL() + path
}}

const loadIndexPage = (dir: string) => Bun.file(dir)
const returnPageResponse = (file: BunFile) => new Response(file)
export default new Router()
    .plug(group(pagesPublicDir.baseURL())).get("/", () => returnPageResponse(loadIndexPage(pagesPublicDir.match("/index.html")))); 