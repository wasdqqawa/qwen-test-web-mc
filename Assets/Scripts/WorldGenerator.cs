using UnityEngine;

public class WorldGenerator : MonoBehaviour
{
    [Header("World Settings")]
    public int worldSize = 16;
    public int worldHeight = 8;

    void Start()
    {
        GenerateWorld();
    }

    void GenerateWorld()
    {
        if (World.Instance == null)
        {
            Debug.LogError("World instance not found! Make sure World object is in the scene.");
            return;
        }

        for (int x = -worldSize / 2; x < worldSize / 2; x++)
        {
            for (int z = -worldSize / 2; z < worldSize / 2; z++)
            {
                // 创建地面
                World.Instance.SetBlock(x, -1, z, BlockType.Bedrock); // 基岩层
                
                for (int y = 0; y < worldHeight; y++)
                {
                    // 创建不同层次的方块
                    BlockType blockType = GetBlockType(x, y, z);
                    if (blockType != BlockType.Air)
                    {
                        World.Instance.SetBlock(x, y, z, blockType);
                    }
                }
            }
        }
    }

    BlockType GetBlockType(int x, int y, int z)
    {
        // 简单的高度图生成
        float height = Mathf.PerlinNoise(x * 0.1f, z * 0.1f) * 5;
        
        if (y == 0) return BlockType.Bedrock; // 基岩
        if (y <= height && y > 0) 
        {
            if (y == (int)height) return BlockType.Grass; // 草方块
            else if (y > (int)height - 3) return BlockType.Dirt; // 泥土
            else return BlockType.Stone; // 石头
        }
        
        return BlockType.Air; // 空气
    }
}