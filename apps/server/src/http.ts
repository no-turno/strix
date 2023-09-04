import { Router } from "@stricjs/router";
import { group } from "@stricjs/utils";
import { loaders } from "./utils";
import pagesEntrySSR from "./public/ssr.entry";

const pagesPublicDir = {
  baseURL: await pagesEntrySSR(),
};

export default new Router()
  .plug(group(pagesPublicDir.baseURL))
  .store("url", pagesPublicDir.baseURL)
  .get("/", ({controller}, store) => {
    return loaders.returnPageResponse(Bun.file(store.url + "/index.html"));
  });
