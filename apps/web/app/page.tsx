// export const dynamic = "force-dynamic"; 
// yaha pr mujhe alag se pnpm install krna padega kyuki, pnpm me @repo/db iske node_modules me aa jayega
import {client} from "@repo/db/client"

// component can be async 
export default async function Home() {
  const user = await client.user.findMany();
  
  return (
    <div>
        {JSON.stringify(user, null, 2)}
    </div>
  );
}

// export const revalidate = 0; 