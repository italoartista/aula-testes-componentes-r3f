import { Canvas } from "@react-three/fiber";
import { Text } from "@react-three/drei";

function App() {
  return (
    <Canvas>
      <mesh>
        <boxGeometry />
        <meshStandardMaterial />
      </mesh>
      <Text
        position={[0, 2, 0]}
        fontSize={1}
        color="pink"
      >
        Hello World
      </Text>
    </Canvas>
  );
}

export default App;