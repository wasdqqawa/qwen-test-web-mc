using UnityEngine;

public class RemotePlayerController : MonoBehaviour
{
    [Header("Player Identity")]
    public string playerId;
    
    [Header("Network Sync")]
    public float lerpSpeed = 10f;
    
    private Vector3 targetPosition;
    private Vector3 targetRotation;
    private bool hasReceivedUpdate = false;
    
    void Start()
    {
        targetPosition = transform.position;
        targetRotation = transform.eulerAngles;
    }
    
    void Update()
    {
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
    }
    
    public void SetPlayerId(string id)
    {
        playerId = id;
        gameObject.name = "RemotePlayer_" + id;
    }
}