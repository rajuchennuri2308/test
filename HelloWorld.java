import com.sun.net.httpserver.HttpServer;
import com.sun.net.httpserver.HttpHandler;
import com.sun.net.httpserver.HttpExchange;
import java.io.IOException;
import java.io.OutputStream;
import java.net.InetSocketAddress;
public class HelloWorld {
    public static void main(String[] args) throws IOException {
        // Create a new HTTP server listening on port 8001
        HttpServer server = HttpServer.create(new InetSocketAddress(8001), 0);
        
        // Create a context for handling requests
        server.createContext("/", new HttpHandler() {
            @Override
            public void handle(HttpExchange exchange) throws IOException {
                // Set the response headers
                exchange.getResponseHeaders().set("Content-Type", "text/html");
                exchange.sendResponseHeaders(200, 0);
                
                // Get the response body stream
                OutputStream responseBody = exchange.getResponseBody();
                
                // Write the HTML content to the response body
                String htmlResponse = "<html><body><h1>Hello, World!</h1></body></html>";
                responseBody.write(htmlResponse.getBytes());
                
                // Close the response body stream
                responseBody.close();
            }
        });
        
        // Start the server
        server.start();
        
        // Output a message indicating the server has started
        System.out.println("Server is listening on port 8001...");
    }
}
