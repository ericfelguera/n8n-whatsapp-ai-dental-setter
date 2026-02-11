/**
 * WhatsApp Session & Conversation Lifecycle Management
 * This script handles multi-tenancy logic and session persistence.
 * 1. Closes inactive sessions (4h timeout).
 * 2. Ensures an open conversation exists for the specific lead.
 * 3. Checks for human intervention status (Human-in-the-Loop).
 */

-- 1. Close inactive conversations (older than 4h) to reset context
UPDATE conversations 
SET status = 'closed' 
WHERE status = 'open' 
AND last_interaction < NOW() - INTERVAL '4 hours';

-- 2. Upsert logic: Ensure an active conversation exists for the lead
INSERT INTO conversations (tenant_id, lead_id, status, paused_by_human)
SELECT 
    '027af666-6e55-4bb5-a2e5-6469de1dcd1e', -- Specific Tenant ID
    '{{ $json.lead_id }}', 
    'open',
    false
WHERE NOT EXISTS (
    SELECT 1 FROM conversations 
    WHERE lead_id = '{{ $json.lead_id }}' 
    AND status = 'open'
);

-- 3. Retrieve session state and AI summary for LangChain context
SELECT id AS conversation_id, paused_by_human, summary
FROM conversations 
WHERE lead_id = '{{ $json.lead_id }}' 
AND status = 'open'
ORDER BY created_at DESC
LIMIT 1;
