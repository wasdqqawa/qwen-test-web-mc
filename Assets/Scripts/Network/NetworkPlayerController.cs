using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class NetworkPlayerController : MonoBehaviour
{
    [Header("Player Identity")]
    public string playerId;
    public bool isLocalPlayer = false;
    
    [Header("Player Appearance")]
    public GameObject playerModel;
    public Material localPlayerMaterial;
    public Material remotePlayerMaterial;
    
    [Header("Network Sync")]
    public float syncRate = 0.1f;
    public float lerpSpeed = 10f;
    
    private Vector3 targetPosition;
    private Vector3 targetRotation;
    private float lastUpdateTime;
    private bool hasReceivedUpdate = false;
    
    void Start()
    {
        targetPosition = transform.position;
        targetRotation = transform.eulerAngles;
        
        if (playerModel != null && localPlayerMaterial != null && remotePlayerMaterial != null)
        {
            Renderer modelRenderer = playerModel.GetComponent<Renderer>();
            if (modelRenderer != null)
            {
                modelRenderer.material = isLocalPlayer ? localPlayerMaterial : remotePlayerMaterial;
            }
        }
    }
    
    void Update()
    {
        if (isLocalPlayer) return; // 本地玩家不需要插值
        
        if (hasReceivedUpdate)
        {
            // 平滑插值到目标位置和旋转
            transform.position = Vector3.Lerp(transform.position, targetPosition, lerpSpeed * Time.deltaTime);
            transform.eulerAngles = Vector3.Slerp(transform.eulerAngles, targetRotation, lerpSpeed * Time.deltaTime);
        }
    }
    
    public void UpdatePlayerPosition(Vector3 newPosition, Vector3 newRotation)
    {
        targetPosition = newPosition;
        targetRotation = newRotation;
        hasReceivedUpdate = true;
        lastUpdateTime = Time.time;
    }
    
    public void SetPlayerId(string id)
    {
        playerId = id;
    }
    
    public void SetAsLocalPlayer()
    {
        isLocalPlayer = true;
        
        if (playerModel != null && localPlayerMaterial != null)
        {
            Renderer modelRenderer = playerModel.GetComponent<Renderer>();
            if (modelRenderer != null)
            {
                modelRenderer.material = localPlayerMaterial;
            }
        }
    }
}