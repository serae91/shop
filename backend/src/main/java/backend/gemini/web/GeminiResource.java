package backend.gemini.web;

import jakarta.enterprise.context.ApplicationScoped;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;

@Path("/gemini")
@Produces(MediaType.TEXT_PLAIN)
@ApplicationScoped
public class GeminiResource {
    @GET
    @Path("/sayHello")
    public String sayHello() {
        return "Hello";
    }

    /*@Inject
    GeminiService geminiService;

    @GET
    @Path("/sayHello")
    public String sayHello() {
        return geminiService.sayHello();
    }

    @GET
    @Path("/ask")
    public String ask(@QueryParam("question") final String question) {
        return geminiService.askGemini(question);
    }

    @POST
    @Path("/ask")
    public String askPost(final String question) {
        return geminiService.askGemini(question);
    }*/
}

