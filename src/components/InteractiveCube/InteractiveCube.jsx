import React, { useState } from "react";

export function InteractiveCube() {
  const [color, setColor] = useState("blue");

  return (
    <mesh
      onClick={() => setColor(color === "blue" ? "red" : "blue")}
      position={[0, 0, 0]}
    >
      <boxGeometry args={[1, 1, 1]} />
      <meshStandardMaterial color={color} />
    </mesh>
  );
}
