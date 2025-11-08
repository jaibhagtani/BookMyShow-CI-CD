import express from "express";
import cors from "cors";
import { client } from "@repo/db/client";

const app = express();

app.use(cors());
app.use(express.json());

app.get("/", (req, res) => res.send("hello ji"));

app.post("/signup", async (req, res) => {
  try {

    console.log(req.body);
    const username = req.body.username;
    const password = req.body.password;

    const user = await client.user.create({
      data: {
        username,
        password
      }
    });

    res.json({
      msg: "Signup successful",
      id: user.id
    });
  } catch (err) {
    console.error(err);
    res.status(500).json({ msg: "Internal server error" });
  }
});

const PORT = process.env.PORT ? Number(process.env.PORT) : 3002;
app.listen(PORT, () => console.log(`Server listening on http://localhost:${PORT}`));
