import Image, { type ImageProps } from "next/image";
import { Button } from "@repo/ui/button";
import styles from "./page.module.css";
// yaha pr mujhe alag se pnpm install krna padega kyuki, pnpm me @repo/db iske node_modules me aa jayega
import { client } from "@repo/db/client"

export default async function Home() {
  const user = await client.user.findMany();
  
  return (
    <div>
      {
        user.map((u) => (
          <div>
            {u?.username} - {u?.password}
          </div>
        ))
      }
    </div>
  );
}
