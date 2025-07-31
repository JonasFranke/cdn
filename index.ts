Bun.serve({
  routes: {
    "/api/status": new Response("OK", { status: 201 }),
    "/img/:id": req => {
      const file = Bun.file(`static/${req.params.id}`);
      return new Response(file);
    }
  },
})
