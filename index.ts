import { Glob } from "bun";

console.log("Starting server...");

const glob = new Glob("static/**/*");

for (const file of glob.scanSync(".")) {
  console.log(`Found file: ${file}`);
}

const server = Bun.serve({
  routes: {
    "/api/status": new Response("OK", { status: 201 }),
    "/img/:id": req => {
      const file = Bun.file(`static/${req.params.id}`);
      return new Response(file);
    }
  },
});

console.log(`Listening on ${server.url}`);
