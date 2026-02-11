# AI Appointment Setter: 24/7 Dental Clinic Receptionist 🦷

This repository showcases a production-ready **AI Agent** designed to qualify patients and book appointments autonomously via WhatsApp. The system acts as a specialized medical receptionist ("Vanessa") that handles lead identification, session persistence, and real-time calendar synchronization.

## ⚙️ Key Technical Features

* **Advanced Lead & Session Management:** Integrated with **PostgreSQL**, the system recognizes returning leads, manages multi-turn conversation states, and maintains a full audit log of every interaction.
* **Human-in-the-Loop (Pause Logic):** A dedicated safety gate checks the `paused_by_human` flag in the database. If a clinic staff member intervenes manually via WhatsApp, the AI automatically steps back to avoid conversational overlap.
* **Intelligent Tool Use (Function Calling):** Powered by **Gemini 2.0 Flash**, the agent proactively uses specialized tools to:
    * `consultar_disponibilidad`: Check real-time gaps in Google Calendar.
    * `confirmar_cita`: Secure the booking once the patient provides their details.
* **Persistent Chat Memory:** Uses `PostgresChatMemory` to ensure the agent remembers the patient's context (e.g., "I have a toothache") even if the connection is interrupted.
* **Hybrid Architecture:** Uses **EvolutionAPI** as the WhatsApp bridge, ensuring high-speed delivery and support for official and non-official WhatsApp instances.

## 🛠️ Tech Stack
* **Orchestrator:** n8n.
* **AI Model:** Google Gemini 2.0 Flash.
* **Database:** PostgreSQL (Relational storage for leads & logs).
* **Calendar:** Google Calendar API.
* **Messaging:** EvolutionAPI (WhatsApp).

## 📊 Live Demonstration

### 1. Conversational AI Logic
The agent follows a strict medical protocol: Greet -> Qualify Pain/Need -> Check Availability -> Confirm Identity -> Finalize Booking.
![WhatsApp AI Conversation](img/whatsapp_chatbot_conversation.jpg)

### 2. Full Workflow Architecture
A robust end-to-end pipeline with state management and database logging.
![n8n Workflow Mastery](img/n8n_chatbot_workflow.jpg)

### 3. Real-Time Scheduling Success
The ultimate goal achieved: A confirmed appointment automatically placed in the clinic's Google Calendar without human intervention.
![Calendar Confirmation](img/chatbot_appointment confirmed.jpg)

## 🚀 The "Python-Core" Roadmap
While this n8n-based version is fully functional for MVP stages, the architecture is designed to migrate its "brain" to a dedicated **FastAPI + LangGraph** microservice. This will allow for more complex branching logic and industrial-scale concurrency as the SaaS scales.

---
*Note: This system solves the "Lead Zombie" problem by responding in <10 seconds, ensuring no patient inquiry goes unanswered.*
