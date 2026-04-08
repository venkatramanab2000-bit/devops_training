import com.sun.net.httpserver.HttpServer;
import com.sun.net.httpserver.HttpHandler;
import com.sun.net.httpserver.HttpExchange;

import java.io.IOException;
import java.io.OutputStream;
import java.net.InetSocketAddress;

public class App {
    public static void main(String[] args) throws IOException {
        HttpServer server = HttpServer.create(new InetSocketAddress("0.0.0.0", 8080), 0);

        server.createContext("/", new MyHandler());
        server.setExecutor(null);
        server.start();

        System.out.println("Server started at http://localhost:8080");
    }

    static class MyHandler implements HttpHandler {
        @Override
        public void handle(HttpExchange exchange) throws IOException {

            String response = "<h1>Hello from Java Docker App 🚀</h1>";

            // Convert to bytes
            byte[] responseBytes = response.getBytes();

            // Add header
            exchange.getResponseHeaders().add("Content-Type", "text/html; charset=UTF-8");

            // Send response
            exchange.sendResponseHeaders(200, responseBytes.length);

            OutputStream os = exchange.getResponseBody();
            os.write(responseBytes);
            os.close();
        }
    }
}