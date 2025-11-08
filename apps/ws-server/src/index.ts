import { WebSocketServer } from "ws";
import { client } from "@repo/db/client"
const server = new WebSocketServer({
    port: 3001
});

server.on("connection", async (socket) => {

    try {
        await client.user.create({
            data: {
                username: Math.random().toString(),
                password: Math.random().toString(),
            },
        });
        socket.send("Hello Ji, Connected to server");
    } catch (err) {
        console.error("Database error:", err);
        socket.send("Error connecting to DB");
    }
})

