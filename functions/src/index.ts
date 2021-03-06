import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
admin.initializeApp();

import { updateConversation } from './conversations/on_user_leaving';
import { saveDetails } from './auth/on_first_sign_in';

// when a new account is created, add auth details to the database
export const saveDetailsOnFirstSignIn = functions.auth.user().onCreate(saveDetails);

// when a user leaves a conversation, update the conversation doc
export const updateConversationOnUserLeaving = functions.firestore.document('conversations/{conversationId}/leave/{userId}').onCreate(updateConversation);
