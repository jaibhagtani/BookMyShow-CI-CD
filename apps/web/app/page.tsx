import Image, { type ImageProps } from "next/image";
import { Button } from "@repo/ui/button";
import styles from "./page.module.css";
// yaha pr mujhe alag se pnpm install krna padega kyuki, pnpm me @repo/db iske node_modules me aa jayega
import {client} from "@repo/db/client"

// component can be async 
export default async function Home() {
  const user = await client.user.findMany();
  
  return (
    <div>
      {
        user.map((u: any) => (
          <div>
            Username : {u?.username} - Password : {u?.password}
          </div>
        ))
      }
    </div>
  );
}
