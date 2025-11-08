import express from "express";
import cors from "cors";
import { client } from "@repo/db/client"; // ensure @repo/db is built and points to dist

const app = express();

// REQUIRED: parse JSON bodies and allow browser requests
app.use(cors());
app.use(express.json({ limit: "2mb" }));

// Simple request logger for debugging
app.use((req, res, next) => {
  console.log(new Date().toISOString(), req.method, req.originalUrl);
  next();
});

app.get("/", (req, res) => res.send("hello ji"));

app.post("/signup", async (req, res) => {
  try {
    console.log("Incoming body:", req.body);
    const { username, password } = req.body ?? {};

    if (!username || !password) {
      return res.status(400).json({ msg: "username and password required" });
    }

    // NOTE: hash password in production (bcrypt / argon2)
    const user = await client.user.create({
      data: { username, password },
    });

    console.log("Created user id=", user.id);
    return res.status(201).json({ msg: "Signup Successful", id: user.id });
  } catch (err: any) {
    console.error("Signup error:", err);
    // Prisma-specific friendly handling
    if (err?.code === "P2002") {
      return res.status(409).json({ msg: "Username already exists" });
    }
    if (err?.code === "P1001") {
      return res.status(500).json({ msg: "Database unreachable (P1001)" });
    }
    return res.status(500).json({ msg: "Internal server error" });
  }
});

const PORT = process.env.PORT ? Number(process.env.PORT) : 3002;
app.listen(PORT, () => console.log(`Server listening on http://localhost:${PORT}`));
