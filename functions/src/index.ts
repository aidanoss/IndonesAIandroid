import { onCall, HttpsError } from "firebase-functions/v2/https";
import { SecretManagerServiceClient } from "@google-cloud/secret-manager";

const secretManager = new SecretManagerServiceClient();
const PROJECT_ID = "indonesai-vcs";

export const getOpenAIKeyV2 = onCall({ 
  region: "asia-southeast1",
  maxInstances: 10
}, async (request) => {
  try {
    console.log("getOpenAIKeyV2 function called");
    
    // Ensure the user is authenticated
    if (!request.auth) {
      console.error("Authentication missing");
      throw new HttpsError(
        "unauthenticated",
        "The function must be called while authenticated."
      );
    }

    console.log("User authenticated, retrieving API key");
    const secretName = `projects/${PROJECT_ID}/secrets/OPENAI_API_KEY/versions/latest`;

    console.log(`Accessing secret: ${secretName}`);
    const [version] = await secretManager.accessSecretVersion({
      name: secretName,
    });

    const apiKey = version.payload?.data?.toString() || "";
    
    if (!apiKey) {
      console.error("API key is empty");
      throw new HttpsError(
        "internal",
        "Failed to retrieve API key"
      );
    }

    console.log("API key retrieved successfully");
    return { key: apiKey };
  } catch (error: any) {
    console.error("Error retrieving OpenAI API key:", error);
    throw new HttpsError(
      "internal",
      `Error retrieving API key: ${error?.message || "Unknown error"}`
    );
  }
});
