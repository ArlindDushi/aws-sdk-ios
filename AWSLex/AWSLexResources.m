//
// Copyright 2010-2020 Amazon.com, Inc. or its affiliates. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License").
// You may not use this file except in compliance with the License.
// A copy of the License is located at
//
// http://aws.amazon.com/apache2.0
//
// or in the "license" file accompanying this file. This file is distributed
// on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
// express or implied. See the License for the specific language governing
// permissions and limitations under the License.
//

#import "AWSLexResources.h"
#import <AWSCore/AWSCocoaLumberjack.h>

@interface AWSLexResources ()

@property (nonatomic, strong) NSDictionary *definitionDictionary;

@end

@implementation AWSLexResources

+ (instancetype)sharedInstance {
    static AWSLexResources *_sharedResources = nil;
    static dispatch_once_t once_token;

    dispatch_once(&once_token, ^{
        _sharedResources = [AWSLexResources new];
    });

    return _sharedResources;
}

- (NSDictionary *)JSONObject {
    return self.definitionDictionary;
}

- (instancetype)init {
    if (self = [super init]) {
        //init method
        NSError *error = nil;
        _definitionDictionary = [NSJSONSerialization JSONObjectWithData:[[self definitionString] dataUsingEncoding:NSUTF8StringEncoding]
                                                                options:kNilOptions
                                                                  error:&error];
        if (_definitionDictionary == nil) {
            if (error) {
                AWSDDLogError(@"Failed to parse JSON service definition: %@",error);
            }
        }
    }
    return self;
}

- (NSString *)definitionString {
    return @"{\
  \"version\":\"2.0\",\
  \"metadata\":{\
    \"apiVersion\":\"2016-11-28\",\
    \"endpointPrefix\":\"runtime.lex\",\
    \"jsonVersion\":\"1.1\",\
    \"protocol\":\"rest-json\",\
    \"serviceFullName\":\"Amazon Lex Runtime Service\",\
    \"serviceId\":\"Lex Runtime Service\",\
    \"signatureVersion\":\"v4\",\
    \"signingName\":\"lex\",\
    \"uid\":\"runtime.lex-2016-11-28\"\
  },\
  \"operations\":{\
    \"DeleteSession\":{\
      \"name\":\"DeleteSession\",\
      \"http\":{\
        \"method\":\"DELETE\",\
        \"requestUri\":\"/bot/{botName}/alias/{botAlias}/user/{userId}/session\"\
      },\
      \"input\":{\"shape\":\"DeleteSessionRequest\"},\
      \"output\":{\"shape\":\"DeleteSessionResponse\"},\
      \"errors\":[\
        {\"shape\":\"NotFoundException\"},\
        {\"shape\":\"BadRequestException\"},\
        {\"shape\":\"LimitExceededException\"},\
        {\"shape\":\"InternalFailureException\"},\
        {\"shape\":\"ConflictException\"}\
      ],\
      \"documentation\":\"<p>Removes session information for a specified bot, alias, and user ID. </p>\"\
    },\
    \"GetSession\":{\
      \"name\":\"GetSession\",\
      \"http\":{\
        \"method\":\"GET\",\
        \"requestUri\":\"/bot/{botName}/alias/{botAlias}/user/{userId}/session/\"\
      },\
      \"input\":{\"shape\":\"GetSessionRequest\"},\
      \"output\":{\"shape\":\"GetSessionResponse\"},\
      \"errors\":[\
        {\"shape\":\"NotFoundException\"},\
        {\"shape\":\"BadRequestException\"},\
        {\"shape\":\"LimitExceededException\"},\
        {\"shape\":\"InternalFailureException\"}\
      ],\
      \"documentation\":\"<p>Returns session information for a specified bot, alias, and user ID.</p>\"\
    },\
    \"PostContent\":{\
      \"name\":\"PostContent\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/bot/{botName}/alias/{botAlias}/user/{userId}/content\"\
      },\
      \"input\":{\"shape\":\"PostContentRequest\"},\
      \"output\":{\"shape\":\"PostContentResponse\"},\
      \"errors\":[\
        {\"shape\":\"NotFoundException\"},\
        {\"shape\":\"BadRequestException\"},\
        {\"shape\":\"LimitExceededException\"},\
        {\"shape\":\"InternalFailureException\"},\
        {\"shape\":\"ConflictException\"},\
        {\"shape\":\"UnsupportedMediaTypeException\"},\
        {\"shape\":\"NotAcceptableException\"},\
        {\"shape\":\"RequestTimeoutException\"},\
        {\"shape\":\"DependencyFailedException\"},\
        {\"shape\":\"BadGatewayException\"},\
        {\"shape\":\"LoopDetectedException\"}\
      ],\
      \"documentation\":\"<p> Sends user input (text or speech) to Amazon Lex. Clients use this API to send text and audio requests to Amazon Lex at runtime. Amazon Lex interprets the user input using the machine learning model that it built for the bot. </p> <p>The <code>PostContent</code> operation supports audio input at 8kHz and 16kHz. You can use 8kHz audio to achieve higher speech recognition accuracy in telephone audio applications. </p> <p> In response, Amazon Lex returns the next message to convey to the user. Consider the following example messages: </p> <ul> <li> <p> For a user input \\\"I would like a pizza,\\\" Amazon Lex might return a response with a message eliciting slot data (for example, <code>PizzaSize</code>): \\\"What size pizza would you like?\\\". </p> </li> <li> <p> After the user provides all of the pizza order information, Amazon Lex might return a response with a message to get user confirmation: \\\"Order the pizza?\\\". </p> </li> <li> <p> After the user replies \\\"Yes\\\" to the confirmation prompt, Amazon Lex might return a conclusion statement: \\\"Thank you, your cheese pizza has been ordered.\\\". </p> </li> </ul> <p> Not all Amazon Lex messages require a response from the user. For example, conclusion statements do not require a response. Some messages require only a yes or no response. In addition to the <code>message</code>, Amazon Lex provides additional context about the message in the response that you can use to enhance client behavior, such as displaying the appropriate client user interface. Consider the following examples: </p> <ul> <li> <p> If the message is to elicit slot data, Amazon Lex returns the following context information: </p> <ul> <li> <p> <code>x-amz-lex-dialog-state</code> header set to <code>ElicitSlot</code> </p> </li> <li> <p> <code>x-amz-lex-intent-name</code> header set to the intent name in the current context </p> </li> <li> <p> <code>x-amz-lex-slot-to-elicit</code> header set to the slot name for which the <code>message</code> is eliciting information </p> </li> <li> <p> <code>x-amz-lex-slots</code> header set to a map of slots configured for the intent with their current values </p> </li> </ul> </li> <li> <p> If the message is a confirmation prompt, the <code>x-amz-lex-dialog-state</code> header is set to <code>Confirmation</code> and the <code>x-amz-lex-slot-to-elicit</code> header is omitted. </p> </li> <li> <p> If the message is a clarification prompt configured for the intent, indicating that the user intent is not understood, the <code>x-amz-dialog-state</code> header is set to <code>ElicitIntent</code> and the <code>x-amz-slot-to-elicit</code> header is omitted. </p> </li> </ul> <p> In addition, Amazon Lex also returns your application-specific <code>sessionAttributes</code>. For more information, see <a href=\\\"https://docs.aws.amazon.com/lex/latest/dg/context-mgmt.html\\\">Managing Conversation Context</a>. </p>\",\
      \"authtype\":\"v4-unsigned-body\"\
    },\
    \"PostText\":{\
      \"name\":\"PostText\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/bot/{botName}/alias/{botAlias}/user/{userId}/text\"\
      },\
      \"input\":{\"shape\":\"PostTextRequest\"},\
      \"output\":{\"shape\":\"PostTextResponse\"},\
      \"errors\":[\
        {\"shape\":\"NotFoundException\"},\
        {\"shape\":\"BadRequestException\"},\
        {\"shape\":\"LimitExceededException\"},\
        {\"shape\":\"InternalFailureException\"},\
        {\"shape\":\"ConflictException\"},\
        {\"shape\":\"DependencyFailedException\"},\
        {\"shape\":\"BadGatewayException\"},\
        {\"shape\":\"LoopDetectedException\"}\
      ],\
      \"documentation\":\"<p>Sends user input to Amazon Lex. Client applications can use this API to send requests to Amazon Lex at runtime. Amazon Lex then interprets the user input using the machine learning model it built for the bot. </p> <p> In response, Amazon Lex returns the next <code>message</code> to convey to the user an optional <code>responseCard</code> to display. Consider the following example messages: </p> <ul> <li> <p> For a user input \\\"I would like a pizza\\\", Amazon Lex might return a response with a message eliciting slot data (for example, PizzaSize): \\\"What size pizza would you like?\\\" </p> </li> <li> <p> After the user provides all of the pizza order information, Amazon Lex might return a response with a message to obtain user confirmation \\\"Proceed with the pizza order?\\\". </p> </li> <li> <p> After the user replies to a confirmation prompt with a \\\"yes\\\", Amazon Lex might return a conclusion statement: \\\"Thank you, your cheese pizza has been ordered.\\\". </p> </li> </ul> <p> Not all Amazon Lex messages require a user response. For example, a conclusion statement does not require a response. Some messages require only a \\\"yes\\\" or \\\"no\\\" user response. In addition to the <code>message</code>, Amazon Lex provides additional context about the message in the response that you might use to enhance client behavior, for example, to display the appropriate client user interface. These are the <code>slotToElicit</code>, <code>dialogState</code>, <code>intentName</code>, and <code>slots</code> fields in the response. Consider the following examples: </p> <ul> <li> <p>If the message is to elicit slot data, Amazon Lex returns the following context information:</p> <ul> <li> <p> <code>dialogState</code> set to ElicitSlot </p> </li> <li> <p> <code>intentName</code> set to the intent name in the current context </p> </li> <li> <p> <code>slotToElicit</code> set to the slot name for which the <code>message</code> is eliciting information </p> </li> <li> <p> <code>slots</code> set to a map of slots, configured for the intent, with currently known values </p> </li> </ul> </li> <li> <p> If the message is a confirmation prompt, the <code>dialogState</code> is set to ConfirmIntent and <code>SlotToElicit</code> is set to null. </p> </li> <li> <p>If the message is a clarification prompt (configured for the intent) that indicates that user intent is not understood, the <code>dialogState</code> is set to ElicitIntent and <code>slotToElicit</code> is set to null. </p> </li> </ul> <p> In addition, Amazon Lex also returns your application-specific <code>sessionAttributes</code>. For more information, see <a href=\\\"https://docs.aws.amazon.com/lex/latest/dg/context-mgmt.html\\\">Managing Conversation Context</a>. </p>\"\
    },\
    \"PutSession\":{\
      \"name\":\"PutSession\",\
      \"http\":{\
        \"method\":\"POST\",\
        \"requestUri\":\"/bot/{botName}/alias/{botAlias}/user/{userId}/session\"\
      },\
      \"input\":{\"shape\":\"PutSessionRequest\"},\
      \"output\":{\"shape\":\"PutSessionResponse\"},\
      \"errors\":[\
        {\"shape\":\"NotFoundException\"},\
        {\"shape\":\"BadRequestException\"},\
        {\"shape\":\"LimitExceededException\"},\
        {\"shape\":\"InternalFailureException\"},\
        {\"shape\":\"ConflictException\"},\
        {\"shape\":\"NotAcceptableException\"},\
        {\"shape\":\"DependencyFailedException\"},\
        {\"shape\":\"BadGatewayException\"}\
      ],\
      \"documentation\":\"<p>Creates a new session or modifies an existing session with an Amazon Lex bot. Use this operation to enable your application to set the state of the bot.</p> <p>For more information, see <a href=\\\"https://docs.aws.amazon.com/lex/latest/dg/how-session-api.html\\\">Managing Sessions</a>.</p>\"\
    }\
  },\
  \"shapes\":{\
    \"Accept\":{\"type\":\"string\"},\
    \"ActiveContext\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"name\",\
        \"timeToLive\",\
        \"parameters\"\
      ],\
      \"members\":{\
        \"name\":{\
          \"shape\":\"ActiveContextName\",\
          \"documentation\":\"<p>The name of the context.</p>\"\
        },\
        \"timeToLive\":{\
          \"shape\":\"ActiveContextTimeToLive\",\
          \"documentation\":\"<p>The length of time or number of turns that a context remains active.</p>\"\
        },\
        \"parameters\":{\
          \"shape\":\"ActiveContextParametersMap\",\
          \"documentation\":\"<p>State variables for the current context. You can use these values as default values for slots in subsequent events.</p>\"\
        }\
      },\
      \"documentation\":\"<p>A context is a variable that contains information about the current state of the conversation between a user and Amazon Lex. Context can be set automatically by Amazon Lex when an intent is fulfilled, or it can be set at runtime using the <code>PutContent</code>, <code>PutText</code>, or <code>PutSession</code> operation.</p>\"\
    },\
    \"ActiveContextName\":{\
      \"type\":\"string\",\
      \"max\":100,\
      \"min\":1,\
      \"pattern\":\"^([A-Za-z]_?)+$\"\
    },\
    \"ActiveContextParametersMap\":{\
      \"type\":\"map\",\
      \"key\":{\"shape\":\"ParameterName\"},\
      \"value\":{\"shape\":\"Text\"},\
      \"max\":10,\
      \"min\":0\
    },\
    \"ActiveContextTimeToLive\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"timeToLiveInSeconds\":{\
          \"shape\":\"ActiveContextTimeToLiveInSeconds\",\
          \"documentation\":\"<p>The number of seconds that the context should be active after it is first sent in a <code>PostContent</code> or <code>PostText</code> response. You can set the value between 5 and 86,400 seconds (24 hours).</p>\"\
        },\
        \"turnsToLive\":{\
          \"shape\":\"ActiveContextTurnsToLive\",\
          \"documentation\":\"<p>The number of conversation turns that the context should be active. A conversation turn is one <code>PostContent</code> or <code>PostText</code> request and the corresponding response from Amazon Lex.</p>\"\
        }\
      },\
      \"documentation\":\"<p>The length of time or number of turns that a context remains active.</p>\"\
    },\
    \"ActiveContextTimeToLiveInSeconds\":{\
      \"type\":\"integer\",\
      \"max\":86400,\
      \"min\":5\
    },\
    \"ActiveContextTurnsToLive\":{\
      \"type\":\"integer\",\
      \"max\":20,\
      \"min\":1\
    },\
    \"ActiveContextsList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"ActiveContext\"},\
      \"max\":20,\
      \"min\":0,\
      \"sensitive\":true\
    },\
    \"ActiveContextsString\":{\
      \"type\":\"string\",\
      \"sensitive\":true\
    },\
    \"AttributesString\":{\
      \"type\":\"string\",\
      \"sensitive\":true\
    },\
    \"BadGatewayException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Message\":{\"shape\":\"ErrorMessage\"}\
      },\
      \"documentation\":\"<p>Either the Amazon Lex bot is still building, or one of the dependent services (Amazon Polly, AWS Lambda) failed with an internal service error.</p>\",\
      \"error\":{\"httpStatusCode\":502},\
      \"exception\":true\
    },\
    \"BadRequestException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"String\"}\
      },\
      \"documentation\":\"<p> Request validation failed, there is no usable message in the context, or the bot build failed, is still in progress, or contains unbuilt changes. </p>\",\
      \"error\":{\"httpStatusCode\":400},\
      \"exception\":true\
    },\
    \"BlobStream\":{\
      \"type\":\"blob\",\
      \"streaming\":true\
    },\
    \"BotAlias\":{\"type\":\"string\"},\
    \"BotName\":{\"type\":\"string\"},\
    \"BotVersion\":{\
      \"type\":\"string\",\
      \"max\":64,\
      \"min\":1,\
      \"pattern\":\"[0-9]+|\\\\$LATEST\"\
    },\
    \"Button\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"text\",\
        \"value\"\
      ],\
      \"members\":{\
        \"text\":{\
          \"shape\":\"ButtonTextStringWithLength\",\
          \"documentation\":\"<p>Text that is visible to the user on the button.</p>\"\
        },\
        \"value\":{\
          \"shape\":\"ButtonValueStringWithLength\",\
          \"documentation\":\"<p>The value sent to Amazon Lex when a user chooses the button. For example, consider button text \\\"NYC.\\\" When the user chooses the button, the value sent can be \\\"New York City.\\\"</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents an option to be shown on the client platform (Facebook, Slack, etc.)</p>\"\
    },\
    \"ButtonTextStringWithLength\":{\
      \"type\":\"string\",\
      \"max\":15,\
      \"min\":1\
    },\
    \"ButtonValueStringWithLength\":{\
      \"type\":\"string\",\
      \"max\":1000,\
      \"min\":1\
    },\
    \"ConfirmationStatus\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"None\",\
        \"Confirmed\",\
        \"Denied\"\
      ]\
    },\
    \"ConflictException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"String\"}\
      },\
      \"documentation\":\"<p> Two clients are using the same AWS account, Amazon Lex bot, and user ID. </p>\",\
      \"error\":{\"httpStatusCode\":409},\
      \"exception\":true\
    },\
    \"ContentType\":{\
      \"type\":\"string\",\
      \"enum\":[\"application/vnd.amazonaws.card.generic\"]\
    },\
    \"DeleteSessionRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"botName\",\
        \"botAlias\",\
        \"userId\"\
      ],\
      \"members\":{\
        \"botName\":{\
          \"shape\":\"BotName\",\
          \"documentation\":\"<p>The name of the bot that contains the session data.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"botName\"\
        },\
        \"botAlias\":{\
          \"shape\":\"BotAlias\",\
          \"documentation\":\"<p>The alias in use for the bot that contains the session data.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"botAlias\"\
        },\
        \"userId\":{\
          \"shape\":\"UserId\",\
          \"documentation\":\"<p>The identifier of the user associated with the session data.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"userId\"\
        }\
      }\
    },\
    \"DeleteSessionResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"botName\":{\
          \"shape\":\"BotName\",\
          \"documentation\":\"<p>The name of the bot associated with the session data.</p>\"\
        },\
        \"botAlias\":{\
          \"shape\":\"BotAlias\",\
          \"documentation\":\"<p>The alias in use for the bot associated with the session data.</p>\"\
        },\
        \"userId\":{\
          \"shape\":\"UserId\",\
          \"documentation\":\"<p>The ID of the client application user.</p>\"\
        },\
        \"sessionId\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>The unique identifier for the session.</p>\"\
        }\
      }\
    },\
    \"DependencyFailedException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Message\":{\"shape\":\"ErrorMessage\"}\
      },\
      \"documentation\":\"<p> One of the dependencies, such as AWS Lambda or Amazon Polly, threw an exception. For example, </p> <ul> <li> <p>If Amazon Lex does not have sufficient permissions to call a Lambda function.</p> </li> <li> <p>If a Lambda function takes longer than 30 seconds to execute.</p> </li> <li> <p>If a fulfillment Lambda function returns a <code>Delegate</code> dialog action without removing any slot values.</p> </li> </ul>\",\
      \"error\":{\"httpStatusCode\":424},\
      \"exception\":true\
    },\
    \"DialogAction\":{\
      \"type\":\"structure\",\
      \"required\":[\"type\"],\
      \"members\":{\
        \"type\":{\
          \"shape\":\"DialogActionType\",\
          \"documentation\":\"<p>The next action that the bot should take in its interaction with the user. The possible values are:</p> <ul> <li> <p> <code>ConfirmIntent</code> - The next action is asking the user if the intent is complete and ready to be fulfilled. This is a yes/no question such as \\\"Place the order?\\\"</p> </li> <li> <p> <code>Close</code> - Indicates that the there will not be a response from the user. For example, the statement \\\"Your order has been placed\\\" does not require a response.</p> </li> <li> <p> <code>Delegate</code> - The next action is determined by Amazon Lex.</p> </li> <li> <p> <code>ElicitIntent</code> - The next action is to determine the intent that the user wants to fulfill.</p> </li> <li> <p> <code>ElicitSlot</code> - The next action is to elicit a slot value from the user.</p> </li> </ul>\"\
        },\
        \"intentName\":{\
          \"shape\":\"IntentName\",\
          \"documentation\":\"<p>The name of the intent.</p>\"\
        },\
        \"slots\":{\
          \"shape\":\"StringMap\",\
          \"documentation\":\"<p>Map of the slots that have been gathered and their values. </p>\"\
        },\
        \"slotToElicit\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>The name of the slot that should be elicited from the user.</p>\"\
        },\
        \"fulfillmentState\":{\
          \"shape\":\"FulfillmentState\",\
          \"documentation\":\"<p>The fulfillment state of the intent. The possible values are:</p> <ul> <li> <p> <code>Failed</code> - The Lambda function associated with the intent failed to fulfill the intent.</p> </li> <li> <p> <code>Fulfilled</code> - The intent has fulfilled by the Lambda function associated with the intent. </p> </li> <li> <p> <code>ReadyForFulfillment</code> - All of the information necessary for the intent is present and the intent ready to be fulfilled by the client application.</p> </li> </ul>\"\
        },\
        \"message\":{\
          \"shape\":\"Text\",\
          \"documentation\":\"<p>The message that should be shown to the user. If you don't specify a message, Amazon Lex will use the message configured for the intent.</p>\"\
        },\
        \"messageFormat\":{\
          \"shape\":\"MessageFormatType\",\
          \"documentation\":\"<ul> <li> <p> <code>PlainText</code> - The message contains plain UTF-8 text.</p> </li> <li> <p> <code>CustomPayload</code> - The message is a custom format for the client.</p> </li> <li> <p> <code>SSML</code> - The message contains text formatted for voice output.</p> </li> <li> <p> <code>Composite</code> - The message contains an escaped JSON object containing one or more messages. For more information, see <a href=\\\"https://docs.aws.amazon.com/lex/latest/dg/howitworks-manage-prompts.html\\\">Message Groups</a>. </p> </li> </ul>\"\
        }\
      },\
      \"documentation\":\"<p>Describes the next action that the bot should take in its interaction with the user and provides information about the context in which the action takes place. Use the <code>DialogAction</code> data type to set the interaction to a specific state, or to return the interaction to a previous state.</p>\"\
    },\
    \"DialogActionType\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"ElicitIntent\",\
        \"ConfirmIntent\",\
        \"ElicitSlot\",\
        \"Close\",\
        \"Delegate\"\
      ]\
    },\
    \"DialogState\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"ElicitIntent\",\
        \"ConfirmIntent\",\
        \"ElicitSlot\",\
        \"Fulfilled\",\
        \"ReadyForFulfillment\",\
        \"Failed\"\
      ]\
    },\
    \"Double\":{\"type\":\"double\"},\
    \"ErrorMessage\":{\"type\":\"string\"},\
    \"FulfillmentState\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"Fulfilled\",\
        \"Failed\",\
        \"ReadyForFulfillment\"\
      ]\
    },\
    \"GenericAttachment\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"title\":{\
          \"shape\":\"StringWithLength\",\
          \"documentation\":\"<p>The title of the option.</p>\"\
        },\
        \"subTitle\":{\
          \"shape\":\"StringWithLength\",\
          \"documentation\":\"<p>The subtitle shown below the title.</p>\"\
        },\
        \"attachmentLinkUrl\":{\
          \"shape\":\"StringUrlWithLength\",\
          \"documentation\":\"<p>The URL of an attachment to the response card.</p>\"\
        },\
        \"imageUrl\":{\
          \"shape\":\"StringUrlWithLength\",\
          \"documentation\":\"<p>The URL of an image that is displayed to the user.</p>\"\
        },\
        \"buttons\":{\
          \"shape\":\"listOfButtons\",\
          \"documentation\":\"<p>The list of options to show to the user.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Represents an option rendered to the user when a prompt is shown. It could be an image, a button, a link, or text. </p>\"\
    },\
    \"GetSessionRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"botName\",\
        \"botAlias\",\
        \"userId\"\
      ],\
      \"members\":{\
        \"botName\":{\
          \"shape\":\"BotName\",\
          \"documentation\":\"<p>The name of the bot that contains the session data.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"botName\"\
        },\
        \"botAlias\":{\
          \"shape\":\"BotAlias\",\
          \"documentation\":\"<p>The alias in use for the bot that contains the session data.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"botAlias\"\
        },\
        \"userId\":{\
          \"shape\":\"UserId\",\
          \"documentation\":\"<p>The ID of the client application user. Amazon Lex uses this to identify a user's conversation with your bot. </p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"userId\"\
        },\
        \"checkpointLabelFilter\":{\
          \"shape\":\"IntentSummaryCheckpointLabel\",\
          \"documentation\":\"<p>A string used to filter the intents returned in the <code>recentIntentSummaryView</code> structure. </p> <p>When you specify a filter, only intents with their <code>checkpointLabel</code> field set to that string are returned.</p>\",\
          \"location\":\"querystring\",\
          \"locationName\":\"checkpointLabelFilter\"\
        }\
      }\
    },\
    \"GetSessionResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"recentIntentSummaryView\":{\
          \"shape\":\"IntentSummaryList\",\
          \"documentation\":\"<p>An array of information about the intents used in the session. The array can contain a maximum of three summaries. If more than three intents are used in the session, the <code>recentIntentSummaryView</code> operation contains information about the last three intents used.</p> <p>If you set the <code>checkpointLabelFilter</code> parameter in the request, the array contains only the intents with the specified label.</p>\"\
        },\
        \"sessionAttributes\":{\
          \"shape\":\"StringMap\",\
          \"documentation\":\"<p>Map of key/value pairs representing the session-specific context information. It contains application information passed between Amazon Lex and a client application.</p>\"\
        },\
        \"sessionId\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>A unique identifier for the session.</p>\"\
        },\
        \"dialogAction\":{\
          \"shape\":\"DialogAction\",\
          \"documentation\":\"<p>Describes the current state of the bot.</p>\"\
        },\
        \"activeContexts\":{\
          \"shape\":\"ActiveContextsList\",\
          \"documentation\":\"<p>A list of active contexts for the session. A context can be set when an intent is fulfilled or by calling the <code>PostContent</code>, <code>PostText</code>, or <code>PutSession</code> operation.</p> <p>You can use a context to control the intents that can follow up an intent, or to modify the operation of your application.</p>\"\
        }\
      }\
    },\
    \"HttpContentType\":{\"type\":\"string\"},\
    \"IntentConfidence\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"score\":{\
          \"shape\":\"Double\",\
          \"documentation\":\"<p>A score that indicates how confident Amazon Lex is that an intent satisfies the user's intent. Ranges between 0.00 and 1.00. Higher scores indicate higher confidence.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Provides a score that indicates the confidence that Amazon Lex has that an intent is the one that satisfies the user's intent.</p>\"\
    },\
    \"IntentList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"PredictedIntent\"},\
      \"max\":4\
    },\
    \"IntentName\":{\"type\":\"string\"},\
    \"IntentSummary\":{\
      \"type\":\"structure\",\
      \"required\":[\"dialogActionType\"],\
      \"members\":{\
        \"intentName\":{\
          \"shape\":\"IntentName\",\
          \"documentation\":\"<p>The name of the intent.</p>\"\
        },\
        \"checkpointLabel\":{\
          \"shape\":\"IntentSummaryCheckpointLabel\",\
          \"documentation\":\"<p>A user-defined label that identifies a particular intent. You can use this label to return to a previous intent. </p> <p>Use the <code>checkpointLabelFilter</code> parameter of the <code>GetSessionRequest</code> operation to filter the intents returned by the operation to those with only the specified label.</p>\"\
        },\
        \"slots\":{\
          \"shape\":\"StringMap\",\
          \"documentation\":\"<p>Map of the slots that have been gathered and their values. </p>\"\
        },\
        \"confirmationStatus\":{\
          \"shape\":\"ConfirmationStatus\",\
          \"documentation\":\"<p>The status of the intent after the user responds to the confirmation prompt. If the user confirms the intent, Amazon Lex sets this field to <code>Confirmed</code>. If the user denies the intent, Amazon Lex sets this value to <code>Denied</code>. The possible values are:</p> <ul> <li> <p> <code>Confirmed</code> - The user has responded \\\"Yes\\\" to the confirmation prompt, confirming that the intent is complete and that it is ready to be fulfilled.</p> </li> <li> <p> <code>Denied</code> - The user has responded \\\"No\\\" to the confirmation prompt.</p> </li> <li> <p> <code>None</code> - The user has never been prompted for confirmation; or, the user was prompted but did not confirm or deny the prompt.</p> </li> </ul>\"\
        },\
        \"dialogActionType\":{\
          \"shape\":\"DialogActionType\",\
          \"documentation\":\"<p>The next action that the bot should take in its interaction with the user. The possible values are:</p> <ul> <li> <p> <code>ConfirmIntent</code> - The next action is asking the user if the intent is complete and ready to be fulfilled. This is a yes/no question such as \\\"Place the order?\\\"</p> </li> <li> <p> <code>Close</code> - Indicates that the there will not be a response from the user. For example, the statement \\\"Your order has been placed\\\" does not require a response.</p> </li> <li> <p> <code>ElicitIntent</code> - The next action is to determine the intent that the user wants to fulfill.</p> </li> <li> <p> <code>ElicitSlot</code> - The next action is to elicit a slot value from the user.</p> </li> </ul>\"\
        },\
        \"fulfillmentState\":{\
          \"shape\":\"FulfillmentState\",\
          \"documentation\":\"<p>The fulfillment state of the intent. The possible values are:</p> <ul> <li> <p> <code>Failed</code> - The Lambda function associated with the intent failed to fulfill the intent.</p> </li> <li> <p> <code>Fulfilled</code> - The intent has fulfilled by the Lambda function associated with the intent. </p> </li> <li> <p> <code>ReadyForFulfillment</code> - All of the information necessary for the intent is present and the intent ready to be fulfilled by the client application.</p> </li> </ul>\"\
        },\
        \"slotToElicit\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>The next slot to elicit from the user. If there is not slot to elicit, the field is blank.</p>\"\
        }\
      },\
      \"documentation\":\"<p>Provides information about the state of an intent. You can use this information to get the current state of an intent so that you can process the intent, or so that you can return the intent to its previous state.</p>\"\
    },\
    \"IntentSummaryCheckpointLabel\":{\
      \"type\":\"string\",\
      \"max\":255,\
      \"min\":1,\
      \"pattern\":\"[a-zA-Z0-9-]+\"\
    },\
    \"IntentSummaryList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"IntentSummary\"},\
      \"max\":3,\
      \"min\":0\
    },\
    \"InternalFailureException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"String\"}\
      },\
      \"documentation\":\"<p>Internal service error. Retry the call.</p>\",\
      \"error\":{\"httpStatusCode\":500},\
      \"exception\":true,\
      \"fault\":true\
    },\
    \"LimitExceededException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"retryAfterSeconds\":{\
          \"shape\":\"String\",\
          \"location\":\"header\",\
          \"locationName\":\"Retry-After\"\
        },\
        \"message\":{\"shape\":\"String\"}\
      },\
      \"documentation\":\"<p>Exceeded a limit.</p>\",\
      \"error\":{\"httpStatusCode\":429},\
      \"exception\":true\
    },\
    \"LoopDetectedException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"Message\":{\"shape\":\"ErrorMessage\"}\
      },\
      \"documentation\":\"<p>This exception is not used.</p>\",\
      \"error\":{\"httpStatusCode\":508},\
      \"exception\":true\
    },\
    \"MessageFormatType\":{\
      \"type\":\"string\",\
      \"enum\":[\
        \"PlainText\",\
        \"CustomPayload\",\
        \"SSML\",\
        \"Composite\"\
      ]\
    },\
    \"NotAcceptableException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"String\"}\
      },\
      \"documentation\":\"<p>The accept header in the request does not have a valid value.</p>\",\
      \"error\":{\"httpStatusCode\":406},\
      \"exception\":true\
    },\
    \"NotFoundException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"String\"}\
      },\
      \"documentation\":\"<p>The resource (such as the Amazon Lex bot or an alias) that is referred to is not found.</p>\",\
      \"error\":{\"httpStatusCode\":404},\
      \"exception\":true\
    },\
    \"ParameterName\":{\
      \"type\":\"string\",\
      \"max\":100,\
      \"min\":1\
    },\
    \"PostContentRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"botName\",\
        \"botAlias\",\
        \"userId\",\
        \"contentType\",\
        \"inputStream\"\
      ],\
      \"members\":{\
        \"botName\":{\
          \"shape\":\"BotName\",\
          \"documentation\":\"<p>Name of the Amazon Lex bot.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"botName\"\
        },\
        \"botAlias\":{\
          \"shape\":\"BotAlias\",\
          \"documentation\":\"<p>Alias of the Amazon Lex bot.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"botAlias\"\
        },\
        \"userId\":{\
          \"shape\":\"UserId\",\
          \"documentation\":\"<p>The ID of the client application user. Amazon Lex uses this to identify a user's conversation with your bot. At runtime, each request must contain the <code>userID</code> field.</p> <p>To decide the user ID to use for your application, consider the following factors.</p> <ul> <li> <p>The <code>userID</code> field must not contain any personally identifiable information of the user, for example, name, personal identification numbers, or other end user personal information.</p> </li> <li> <p>If you want a user to start a conversation on one device and continue on another device, use a user-specific identifier.</p> </li> <li> <p>If you want the same user to be able to have two independent conversations on two different devices, choose a device-specific identifier.</p> </li> <li> <p>A user can't have two independent conversations with two different versions of the same bot. For example, a user can't have a conversation with the PROD and BETA versions of the same bot. If you anticipate that a user will need to have conversation with two different versions, for example, while testing, include the bot alias in the user ID to separate the two conversations.</p> </li> </ul>\",\
          \"location\":\"uri\",\
          \"locationName\":\"userId\"\
        },\
        \"sessionAttributes\":{\
          \"shape\":\"AttributesString\",\
          \"documentation\":\"<p>You pass this value as the <code>x-amz-lex-session-attributes</code> HTTP header.</p> <p>Application-specific information passed between Amazon Lex and a client application. The value must be a JSON serialized and base64 encoded map with string keys and values. The total size of the <code>sessionAttributes</code> and <code>requestAttributes</code> headers is limited to 12 KB.</p> <p>For more information, see <a href=\\\"https://docs.aws.amazon.com/lex/latest/dg/context-mgmt.html#context-mgmt-session-attribs\\\">Setting Session Attributes</a>.</p>\",\
          \"jsonvalue\":true,\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-lex-session-attributes\"\
        },\
        \"requestAttributes\":{\
          \"shape\":\"AttributesString\",\
          \"documentation\":\"<p>You pass this value as the <code>x-amz-lex-request-attributes</code> HTTP header.</p> <p>Request-specific information passed between Amazon Lex and a client application. The value must be a JSON serialized and base64 encoded map with string keys and values. The total size of the <code>requestAttributes</code> and <code>sessionAttributes</code> headers is limited to 12 KB.</p> <p>The namespace <code>x-amz-lex:</code> is reserved for special attributes. Don't create any request attributes with the prefix <code>x-amz-lex:</code>.</p> <p>For more information, see <a href=\\\"https://docs.aws.amazon.com/lex/latest/dg/context-mgmt.html#context-mgmt-request-attribs\\\">Setting Request Attributes</a>.</p>\",\
          \"jsonvalue\":true,\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-lex-request-attributes\"\
        },\
        \"contentType\":{\
          \"shape\":\"HttpContentType\",\
          \"documentation\":\"<p> You pass this value as the <code>Content-Type</code> HTTP header. </p> <p> Indicates the audio format or text. The header value must start with one of the following prefixes: </p> <ul> <li> <p>PCM format, audio data must be in little-endian byte order.</p> <ul> <li> <p>audio/l16; rate=16000; channels=1</p> </li> <li> <p>audio/x-l16; sample-rate=16000; channel-count=1</p> </li> <li> <p>audio/lpcm; sample-rate=8000; sample-size-bits=16; channel-count=1; is-big-endian=false </p> </li> </ul> </li> <li> <p>Opus format</p> <ul> <li> <p>audio/x-cbr-opus-with-preamble; preamble-size=0; bit-rate=256000; frame-size-milliseconds=4</p> </li> </ul> </li> <li> <p>Text format</p> <ul> <li> <p>text/plain; charset=utf-8</p> </li> </ul> </li> </ul>\",\
          \"location\":\"header\",\
          \"locationName\":\"Content-Type\"\
        },\
        \"accept\":{\
          \"shape\":\"Accept\",\
          \"documentation\":\"<p> You pass this value as the <code>Accept</code> HTTP header. </p> <p> The message Amazon Lex returns in the response can be either text or speech based on the <code>Accept</code> HTTP header value in the request. </p> <ul> <li> <p> If the value is <code>text/plain; charset=utf-8</code>, Amazon Lex returns text in the response. </p> </li> <li> <p> If the value begins with <code>audio/</code>, Amazon Lex returns speech in the response. Amazon Lex uses Amazon Polly to generate the speech (using the configuration you specified in the <code>Accept</code> header). For example, if you specify <code>audio/mpeg</code> as the value, Amazon Lex returns speech in the MPEG format.</p> </li> <li> <p>If the value is <code>audio/pcm</code>, the speech returned is <code>audio/pcm</code> in 16-bit, little endian format. </p> </li> <li> <p>The following are the accepted values:</p> <ul> <li> <p>audio/mpeg</p> </li> <li> <p>audio/ogg</p> </li> <li> <p>audio/pcm</p> </li> <li> <p>text/plain; charset=utf-8</p> </li> <li> <p>audio/* (defaults to mpeg)</p> </li> </ul> </li> </ul>\",\
          \"location\":\"header\",\
          \"locationName\":\"Accept\"\
        },\
        \"inputStream\":{\
          \"shape\":\"BlobStream\",\
          \"documentation\":\"<p> User input in PCM or Opus audio format or text format as described in the <code>Content-Type</code> HTTP header. </p> <p>You can stream audio data to Amazon Lex or you can create a local buffer that captures all of the audio data before sending. In general, you get better performance if you stream audio data rather than buffering the data locally.</p>\"\
        },\
        \"activeContexts\":{\
          \"shape\":\"ActiveContextsString\",\
          \"documentation\":\"<p>A list of contexts active for the request. A context can be activated when a previous intent is fulfilled, or by including the context in the request,</p> <p>If you don't specify a list of contexts, Amazon Lex will use the current list of contexts for the session. If you specify an empty list, all contexts for the session are cleared.</p>\",\
          \"jsonvalue\":true,\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-lex-active-contexts\"\
        }\
      },\
      \"payload\":\"inputStream\"\
    },\
    \"PostContentResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"contentType\":{\
          \"shape\":\"HttpContentType\",\
          \"documentation\":\"<p>Content type as specified in the <code>Accept</code> HTTP header in the request.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"Content-Type\"\
        },\
        \"intentName\":{\
          \"shape\":\"IntentName\",\
          \"documentation\":\"<p>Current user intent that Amazon Lex is aware of.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-lex-intent-name\"\
        },\
        \"nluIntentConfidence\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>Provides a score that indicates how confident Amazon Lex is that the returned intent is the one that matches the user's intent. The score is between 0.0 and 1.0.</p> <p>The score is a relative score, not an absolute score. The score may change based on improvements to Amazon Lex. </p>\",\
          \"jsonvalue\":true,\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-lex-nlu-intent-confidence\"\
        },\
        \"alternativeIntents\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>One to four alternative intents that may be applicable to the user's intent.</p> <p>Each alternative includes a score that indicates how confident Amazon Lex is that the intent matches the user's intent. The intents are sorted by the confidence score.</p>\",\
          \"jsonvalue\":true,\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-lex-alternative-intents\"\
        },\
        \"slots\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>Map of zero or more intent slots (name/value pairs) Amazon Lex detected from the user input during the conversation. The field is base-64 encoded.</p> <p>Amazon Lex creates a resolution list containing likely values for a slot. The value that it returns is determined by the <code>valueSelectionStrategy</code> selected when the slot type was created or updated. If <code>valueSelectionStrategy</code> is set to <code>ORIGINAL_VALUE</code>, the value provided by the user is returned, if the user value is similar to the slot values. If <code>valueSelectionStrategy</code> is set to <code>TOP_RESOLUTION</code> Amazon Lex returns the first value in the resolution list or, if there is no resolution list, null. If you don't specify a <code>valueSelectionStrategy</code>, the default is <code>ORIGINAL_VALUE</code>.</p>\",\
          \"jsonvalue\":true,\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-lex-slots\"\
        },\
        \"sessionAttributes\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p> Map of key/value pairs representing the session-specific context information. </p>\",\
          \"jsonvalue\":true,\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-lex-session-attributes\"\
        },\
        \"sentimentResponse\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>The sentiment expressed in an utterance.</p> <p>When the bot is configured to send utterances to Amazon Comprehend for sentiment analysis, this field contains the result of the analysis.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-lex-sentiment\"\
        },\
        \"message\":{\
          \"shape\":\"Text\",\
          \"documentation\":\"<p>The message to convey to the user. The message can come from the bot's configuration or from a Lambda function.</p> <p>If the intent is not configured with a Lambda function, or if the Lambda function returned <code>Delegate</code> as the <code>dialogAction.type</code> in its response, Amazon Lex decides on the next course of action and selects an appropriate message from the bot's configuration based on the current interaction context. For example, if Amazon Lex isn't able to understand user input, it uses a clarification prompt message.</p> <p>When you create an intent you can assign messages to groups. When messages are assigned to groups Amazon Lex returns one message from each group in the response. The message field is an escaped JSON string containing the messages. For more information about the structure of the JSON string returned, see <a>msg-prompts-formats</a>.</p> <p>If the Lambda function returns a message, Amazon Lex passes it to the client in its response.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-lex-message\"\
        },\
        \"messageFormat\":{\
          \"shape\":\"MessageFormatType\",\
          \"documentation\":\"<p>The format of the response message. One of the following values:</p> <ul> <li> <p> <code>PlainText</code> - The message contains plain UTF-8 text.</p> </li> <li> <p> <code>CustomPayload</code> - The message is a custom format for the client.</p> </li> <li> <p> <code>SSML</code> - The message contains text formatted for voice output.</p> </li> <li> <p> <code>Composite</code> - The message contains an escaped JSON object containing one or more messages from the groups that messages were assigned to when the intent was created.</p> </li> </ul>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-lex-message-format\"\
        },\
        \"dialogState\":{\
          \"shape\":\"DialogState\",\
          \"documentation\":\"<p>Identifies the current state of the user interaction. Amazon Lex returns one of the following values as <code>dialogState</code>. The client can optionally use this information to customize the user interface. </p> <ul> <li> <p> <code>ElicitIntent</code> - Amazon Lex wants to elicit the user's intent. Consider the following examples: </p> <p> For example, a user might utter an intent (\\\"I want to order a pizza\\\"). If Amazon Lex cannot infer the user intent from this utterance, it will return this dialog state. </p> </li> <li> <p> <code>ConfirmIntent</code> - Amazon Lex is expecting a \\\"yes\\\" or \\\"no\\\" response. </p> <p>For example, Amazon Lex wants user confirmation before fulfilling an intent. Instead of a simple \\\"yes\\\" or \\\"no\\\" response, a user might respond with additional information. For example, \\\"yes, but make it a thick crust pizza\\\" or \\\"no, I want to order a drink.\\\" Amazon Lex can process such additional information (in these examples, update the crust type slot or change the intent from OrderPizza to OrderDrink). </p> </li> <li> <p> <code>ElicitSlot</code> - Amazon Lex is expecting the value of a slot for the current intent. </p> <p> For example, suppose that in the response Amazon Lex sends this message: \\\"What size pizza would you like?\\\". A user might reply with the slot value (e.g., \\\"medium\\\"). The user might also provide additional information in the response (e.g., \\\"medium thick crust pizza\\\"). Amazon Lex can process such additional information appropriately. </p> </li> <li> <p> <code>Fulfilled</code> - Conveys that the Lambda function has successfully fulfilled the intent. </p> </li> <li> <p> <code>ReadyForFulfillment</code> - Conveys that the client has to fulfill the request. </p> </li> <li> <p> <code>Failed</code> - Conveys that the conversation with the user failed. </p> <p> This can happen for various reasons, including that the user does not provide an appropriate response to prompts from the service (you can configure how many times Amazon Lex can prompt a user for specific information), or if the Lambda function fails to fulfill the intent. </p> </li> </ul>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-lex-dialog-state\"\
        },\
        \"slotToElicit\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p> If the <code>dialogState</code> value is <code>ElicitSlot</code>, returns the name of the slot for which Amazon Lex is eliciting a value. </p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-lex-slot-to-elicit\"\
        },\
        \"inputTranscript\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>The text used to process the request.</p> <p>If the input was an audio stream, the <code>inputTranscript</code> field contains the text extracted from the audio stream. This is the text that is actually processed to recognize intents and slot values. You can use this information to determine if Amazon Lex is correctly processing the audio that you send.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-lex-input-transcript\"\
        },\
        \"audioStream\":{\
          \"shape\":\"BlobStream\",\
          \"documentation\":\"<p>The prompt (or statement) to convey to the user. This is based on the bot configuration and context. For example, if Amazon Lex did not understand the user intent, it sends the <code>clarificationPrompt</code> configured for the bot. If the intent requires confirmation before taking the fulfillment action, it sends the <code>confirmationPrompt</code>. Another example: Suppose that the Lambda function successfully fulfilled the intent, and sent a message to convey to the user. Then Amazon Lex sends that message in the response. </p>\"\
        },\
        \"botVersion\":{\
          \"shape\":\"BotVersion\",\
          \"documentation\":\"<p>The version of the bot that responded to the conversation. You can use this information to help determine if one version of a bot is performing better than another version.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-lex-bot-version\"\
        },\
        \"sessionId\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>The unique identifier for the session.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-lex-session-id\"\
        },\
        \"activeContexts\":{\
          \"shape\":\"ActiveContextsString\",\
          \"documentation\":\"<p>A list of active contexts for the session. A context can be set when an intent is fulfilled or by calling the <code>PostContent</code>, <code>PostText</code>, or <code>PutSession</code> operation.</p> <p>You can use a context to control the intents that can follow up an intent, or to modify the operation of your application.</p>\",\
          \"jsonvalue\":true,\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-lex-active-contexts\"\
        }\
      },\
      \"payload\":\"audioStream\"\
    },\
    \"PostTextRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"botName\",\
        \"botAlias\",\
        \"userId\",\
        \"inputText\"\
      ],\
      \"members\":{\
        \"botName\":{\
          \"shape\":\"BotName\",\
          \"documentation\":\"<p>The name of the Amazon Lex bot.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"botName\"\
        },\
        \"botAlias\":{\
          \"shape\":\"BotAlias\",\
          \"documentation\":\"<p>The alias of the Amazon Lex bot.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"botAlias\"\
        },\
        \"userId\":{\
          \"shape\":\"UserId\",\
          \"documentation\":\"<p>The ID of the client application user. Amazon Lex uses this to identify a user's conversation with your bot. At runtime, each request must contain the <code>userID</code> field.</p> <p>To decide the user ID to use for your application, consider the following factors.</p> <ul> <li> <p>The <code>userID</code> field must not contain any personally identifiable information of the user, for example, name, personal identification numbers, or other end user personal information.</p> </li> <li> <p>If you want a user to start a conversation on one device and continue on another device, use a user-specific identifier.</p> </li> <li> <p>If you want the same user to be able to have two independent conversations on two different devices, choose a device-specific identifier.</p> </li> <li> <p>A user can't have two independent conversations with two different versions of the same bot. For example, a user can't have a conversation with the PROD and BETA versions of the same bot. If you anticipate that a user will need to have conversation with two different versions, for example, while testing, include the bot alias in the user ID to separate the two conversations.</p> </li> </ul>\",\
          \"location\":\"uri\",\
          \"locationName\":\"userId\"\
        },\
        \"sessionAttributes\":{\
          \"shape\":\"StringMap\",\
          \"documentation\":\"<p>Application-specific information passed between Amazon Lex and a client application.</p> <p>For more information, see <a href=\\\"https://docs.aws.amazon.com/lex/latest/dg/context-mgmt.html#context-mgmt-session-attribs\\\">Setting Session Attributes</a>.</p>\"\
        },\
        \"requestAttributes\":{\
          \"shape\":\"StringMap\",\
          \"documentation\":\"<p>Request-specific information passed between Amazon Lex and a client application.</p> <p>The namespace <code>x-amz-lex:</code> is reserved for special attributes. Don't create any request attributes with the prefix <code>x-amz-lex:</code>.</p> <p>For more information, see <a href=\\\"https://docs.aws.amazon.com/lex/latest/dg/context-mgmt.html#context-mgmt-request-attribs\\\">Setting Request Attributes</a>.</p>\"\
        },\
        \"inputText\":{\
          \"shape\":\"Text\",\
          \"documentation\":\"<p>The text that the user entered (Amazon Lex interprets this text).</p>\"\
        },\
        \"activeContexts\":{\
          \"shape\":\"ActiveContextsList\",\
          \"documentation\":\"<p>A list of contexts active for the request. A context can be activated when a previous intent is fulfilled, or by including the context in the request,</p> <p>If you don't specify a list of contexts, Amazon Lex will use the current list of contexts for the session. If you specify an empty list, all contexts for the session are cleared.</p>\"\
        }\
      }\
    },\
    \"PostTextResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"intentName\":{\
          \"shape\":\"IntentName\",\
          \"documentation\":\"<p>The current user intent that Amazon Lex is aware of.</p>\"\
        },\
        \"nluIntentConfidence\":{\
          \"shape\":\"IntentConfidence\",\
          \"documentation\":\"<p>Provides a score that indicates how confident Amazon Lex is that the returned intent is the one that matches the user's intent. The score is between 0.0 and 1.0. For more information, see <a href=\\\"https://docs.aws.amazon.com/lex/latest/dg/confidence-scores.html\\\">Confidence Scores</a>.</p> <p>The score is a relative score, not an absolute score. The score may change based on improvements to Amazon Lex.</p>\"\
        },\
        \"alternativeIntents\":{\
          \"shape\":\"IntentList\",\
          \"documentation\":\"<p>One to four alternative intents that may be applicable to the user's intent.</p> <p>Each alternative includes a score that indicates how confident Amazon Lex is that the intent matches the user's intent. The intents are sorted by the confidence score.</p>\"\
        },\
        \"slots\":{\
          \"shape\":\"StringMap\",\
          \"documentation\":\"<p> The intent slots that Amazon Lex detected from the user input in the conversation. </p> <p>Amazon Lex creates a resolution list containing likely values for a slot. The value that it returns is determined by the <code>valueSelectionStrategy</code> selected when the slot type was created or updated. If <code>valueSelectionStrategy</code> is set to <code>ORIGINAL_VALUE</code>, the value provided by the user is returned, if the user value is similar to the slot values. If <code>valueSelectionStrategy</code> is set to <code>TOP_RESOLUTION</code> Amazon Lex returns the first value in the resolution list or, if there is no resolution list, null. If you don't specify a <code>valueSelectionStrategy</code>, the default is <code>ORIGINAL_VALUE</code>.</p>\"\
        },\
        \"sessionAttributes\":{\
          \"shape\":\"StringMap\",\
          \"documentation\":\"<p>A map of key-value pairs representing the session-specific context information.</p>\"\
        },\
        \"message\":{\
          \"shape\":\"Text\",\
          \"documentation\":\"<p>The message to convey to the user. The message can come from the bot's configuration or from a Lambda function.</p> <p>If the intent is not configured with a Lambda function, or if the Lambda function returned <code>Delegate</code> as the <code>dialogAction.type</code> its response, Amazon Lex decides on the next course of action and selects an appropriate message from the bot's configuration based on the current interaction context. For example, if Amazon Lex isn't able to understand user input, it uses a clarification prompt message.</p> <p>When you create an intent you can assign messages to groups. When messages are assigned to groups Amazon Lex returns one message from each group in the response. The message field is an escaped JSON string containing the messages. For more information about the structure of the JSON string returned, see <a>msg-prompts-formats</a>.</p> <p>If the Lambda function returns a message, Amazon Lex passes it to the client in its response.</p>\"\
        },\
        \"sentimentResponse\":{\
          \"shape\":\"SentimentResponse\",\
          \"documentation\":\"<p>The sentiment expressed in and utterance.</p> <p>When the bot is configured to send utterances to Amazon Comprehend for sentiment analysis, this field contains the result of the analysis.</p>\"\
        },\
        \"messageFormat\":{\
          \"shape\":\"MessageFormatType\",\
          \"documentation\":\"<p>The format of the response message. One of the following values:</p> <ul> <li> <p> <code>PlainText</code> - The message contains plain UTF-8 text.</p> </li> <li> <p> <code>CustomPayload</code> - The message is a custom format defined by the Lambda function.</p> </li> <li> <p> <code>SSML</code> - The message contains text formatted for voice output.</p> </li> <li> <p> <code>Composite</code> - The message contains an escaped JSON object containing one or more messages from the groups that messages were assigned to when the intent was created.</p> </li> </ul>\"\
        },\
        \"dialogState\":{\
          \"shape\":\"DialogState\",\
          \"documentation\":\"<p> Identifies the current state of the user interaction. Amazon Lex returns one of the following values as <code>dialogState</code>. The client can optionally use this information to customize the user interface. </p> <ul> <li> <p> <code>ElicitIntent</code> - Amazon Lex wants to elicit user intent. </p> <p>For example, a user might utter an intent (\\\"I want to order a pizza\\\"). If Amazon Lex cannot infer the user intent from this utterance, it will return this dialogState.</p> </li> <li> <p> <code>ConfirmIntent</code> - Amazon Lex is expecting a \\\"yes\\\" or \\\"no\\\" response. </p> <p> For example, Amazon Lex wants user confirmation before fulfilling an intent. </p> <p>Instead of a simple \\\"yes\\\" or \\\"no,\\\" a user might respond with additional information. For example, \\\"yes, but make it thick crust pizza\\\" or \\\"no, I want to order a drink\\\". Amazon Lex can process such additional information (in these examples, update the crust type slot value, or change intent from OrderPizza to OrderDrink).</p> </li> <li> <p> <code>ElicitSlot</code> - Amazon Lex is expecting a slot value for the current intent. </p> <p>For example, suppose that in the response Amazon Lex sends this message: \\\"What size pizza would you like?\\\". A user might reply with the slot value (e.g., \\\"medium\\\"). The user might also provide additional information in the response (e.g., \\\"medium thick crust pizza\\\"). Amazon Lex can process such additional information appropriately. </p> </li> <li> <p> <code>Fulfilled</code> - Conveys that the Lambda function configured for the intent has successfully fulfilled the intent. </p> </li> <li> <p> <code>ReadyForFulfillment</code> - Conveys that the client has to fulfill the intent. </p> </li> <li> <p> <code>Failed</code> - Conveys that the conversation with the user failed. </p> <p> This can happen for various reasons including that the user did not provide an appropriate response to prompts from the service (you can configure how many times Amazon Lex can prompt a user for specific information), or the Lambda function failed to fulfill the intent. </p> </li> </ul>\"\
        },\
        \"slotToElicit\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>If the <code>dialogState</code> value is <code>ElicitSlot</code>, returns the name of the slot for which Amazon Lex is eliciting a value. </p>\"\
        },\
        \"responseCard\":{\
          \"shape\":\"ResponseCard\",\
          \"documentation\":\"<p>Represents the options that the user has to respond to the current prompt. Response Card can come from the bot configuration (in the Amazon Lex console, choose the settings button next to a slot) or from a code hook (Lambda function). </p>\"\
        },\
        \"sessionId\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>A unique identifier for the session.</p>\"\
        },\
        \"botVersion\":{\
          \"shape\":\"BotVersion\",\
          \"documentation\":\"<p>The version of the bot that responded to the conversation. You can use this information to help determine if one version of a bot is performing better than another version.</p>\"\
        },\
        \"activeContexts\":{\
          \"shape\":\"ActiveContextsList\",\
          \"documentation\":\"<p>A list of active contexts for the session. A context can be set when an intent is fulfilled or by calling the <code>PostContent</code>, <code>PostText</code>, or <code>PutSession</code> operation.</p> <p>You can use a context to control the intents that can follow up an intent, or to modify the operation of your application.</p>\"\
        }\
      }\
    },\
    \"PredictedIntent\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"intentName\":{\
          \"shape\":\"IntentName\",\
          \"documentation\":\"<p>The name of the intent that Amazon Lex suggests satisfies the user's intent.</p>\"\
        },\
        \"nluIntentConfidence\":{\
          \"shape\":\"IntentConfidence\",\
          \"documentation\":\"<p>Indicates how confident Amazon Lex is that an intent satisfies the user's intent.</p>\"\
        },\
        \"slots\":{\
          \"shape\":\"StringMap\",\
          \"documentation\":\"<p>The slot and slot values associated with the predicted intent.</p>\"\
        }\
      },\
      \"documentation\":\"<p>An intent that Amazon Lex suggests satisfies the user's intent. Includes the name of the intent, the confidence that Amazon Lex has that the user's intent is satisfied, and the slots defined for the intent.</p>\"\
    },\
    \"PutSessionRequest\":{\
      \"type\":\"structure\",\
      \"required\":[\
        \"botName\",\
        \"botAlias\",\
        \"userId\"\
      ],\
      \"members\":{\
        \"botName\":{\
          \"shape\":\"BotName\",\
          \"documentation\":\"<p>The name of the bot that contains the session data.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"botName\"\
        },\
        \"botAlias\":{\
          \"shape\":\"BotAlias\",\
          \"documentation\":\"<p>The alias in use for the bot that contains the session data.</p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"botAlias\"\
        },\
        \"userId\":{\
          \"shape\":\"UserId\",\
          \"documentation\":\"<p>The ID of the client application user. Amazon Lex uses this to identify a user's conversation with your bot. </p>\",\
          \"location\":\"uri\",\
          \"locationName\":\"userId\"\
        },\
        \"sessionAttributes\":{\
          \"shape\":\"StringMap\",\
          \"documentation\":\"<p>Map of key/value pairs representing the session-specific context information. It contains application information passed between Amazon Lex and a client application.</p>\"\
        },\
        \"dialogAction\":{\
          \"shape\":\"DialogAction\",\
          \"documentation\":\"<p>Sets the next action that the bot should take to fulfill the conversation.</p>\"\
        },\
        \"recentIntentSummaryView\":{\
          \"shape\":\"IntentSummaryList\",\
          \"documentation\":\"<p>A summary of the recent intents for the bot. You can use the intent summary view to set a checkpoint label on an intent and modify attributes of intents. You can also use it to remove or add intent summary objects to the list.</p> <p>An intent that you modify or add to the list must make sense for the bot. For example, the intent name must be valid for the bot. You must provide valid values for:</p> <ul> <li> <p> <code>intentName</code> </p> </li> <li> <p>slot names</p> </li> <li> <p> <code>slotToElict</code> </p> </li> </ul> <p>If you send the <code>recentIntentSummaryView</code> parameter in a <code>PutSession</code> request, the contents of the new summary view replaces the old summary view. For example, if a <code>GetSession</code> request returns three intents in the summary view and you call <code>PutSession</code> with one intent in the summary view, the next call to <code>GetSession</code> will only return one intent.</p>\"\
        },\
        \"accept\":{\
          \"shape\":\"Accept\",\
          \"documentation\":\"<p>The message that Amazon Lex returns in the response can be either text or speech based depending on the value of this field.</p> <ul> <li> <p>If the value is <code>text/plain; charset=utf-8</code>, Amazon Lex returns text in the response.</p> </li> <li> <p>If the value begins with <code>audio/</code>, Amazon Lex returns speech in the response. Amazon Lex uses Amazon Polly to generate the speech in the configuration that you specify. For example, if you specify <code>audio/mpeg</code> as the value, Amazon Lex returns speech in the MPEG format.</p> </li> <li> <p>If the value is <code>audio/pcm</code>, the speech is returned as <code>audio/pcm</code> in 16-bit, little endian format.</p> </li> <li> <p>The following are the accepted values:</p> <ul> <li> <p> <code>audio/mpeg</code> </p> </li> <li> <p> <code>audio/ogg</code> </p> </li> <li> <p> <code>audio/pcm</code> </p> </li> <li> <p> <code>audio/*</code> (defaults to mpeg)</p> </li> <li> <p> <code>text/plain; charset=utf-8</code> </p> </li> </ul> </li> </ul>\",\
          \"location\":\"header\",\
          \"locationName\":\"Accept\"\
        },\
        \"activeContexts\":{\
          \"shape\":\"ActiveContextsList\",\
          \"documentation\":\"<p>A list of contexts active for the request. A context can be activated when a previous intent is fulfilled, or by including the context in the request,</p> <p>If you don't specify a list of contexts, Amazon Lex will use the current list of contexts for the session. If you specify an empty list, all contexts for the session are cleared.</p>\"\
        }\
      }\
    },\
    \"PutSessionResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"contentType\":{\
          \"shape\":\"HttpContentType\",\
          \"documentation\":\"<p>Content type as specified in the <code>Accept</code> HTTP header in the request.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"Content-Type\"\
        },\
        \"intentName\":{\
          \"shape\":\"IntentName\",\
          \"documentation\":\"<p>The name of the current intent.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-lex-intent-name\"\
        },\
        \"slots\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>Map of zero or more intent slots Amazon Lex detected from the user input during the conversation.</p> <p>Amazon Lex creates a resolution list containing likely values for a slot. The value that it returns is determined by the <code>valueSelectionStrategy</code> selected when the slot type was created or updated. If <code>valueSelectionStrategy</code> is set to <code>ORIGINAL_VALUE</code>, the value provided by the user is returned, if the user value is similar to the slot values. If <code>valueSelectionStrategy</code> is set to <code>TOP_RESOLUTION</code> Amazon Lex returns the first value in the resolution list or, if there is no resolution list, null. If you don't specify a <code>valueSelectionStrategy</code> the default is <code>ORIGINAL_VALUE</code>. </p>\",\
          \"jsonvalue\":true,\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-lex-slots\"\
        },\
        \"sessionAttributes\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>Map of key/value pairs representing session-specific context information.</p>\",\
          \"jsonvalue\":true,\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-lex-session-attributes\"\
        },\
        \"message\":{\
          \"shape\":\"Text\",\
          \"documentation\":\"<p>The next message that should be presented to the user.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-lex-message\"\
        },\
        \"messageFormat\":{\
          \"shape\":\"MessageFormatType\",\
          \"documentation\":\"<p>The format of the response message. One of the following values:</p> <ul> <li> <p> <code>PlainText</code> - The message contains plain UTF-8 text.</p> </li> <li> <p> <code>CustomPayload</code> - The message is a custom format for the client.</p> </li> <li> <p> <code>SSML</code> - The message contains text formatted for voice output.</p> </li> <li> <p> <code>Composite</code> - The message contains an escaped JSON object containing one or more messages from the groups that messages were assigned to when the intent was created.</p> </li> </ul>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-lex-message-format\"\
        },\
        \"dialogState\":{\
          \"shape\":\"DialogState\",\
          \"documentation\":\"<p/> <ul> <li> <p> <code>ConfirmIntent</code> - Amazon Lex is expecting a \\\"yes\\\" or \\\"no\\\" response to confirm the intent before fulfilling an intent.</p> </li> <li> <p> <code>ElicitIntent</code> - Amazon Lex wants to elicit the user's intent.</p> </li> <li> <p> <code>ElicitSlot</code> - Amazon Lex is expecting the value of a slot for the current intent.</p> </li> <li> <p> <code>Failed</code> - Conveys that the conversation with the user has failed. This can happen for various reasons, including the user does not provide an appropriate response to prompts from the service, or if the Lambda function fails to fulfill the intent.</p> </li> <li> <p> <code>Fulfilled</code> - Conveys that the Lambda function has sucessfully fulfilled the intent.</p> </li> <li> <p> <code>ReadyForFulfillment</code> - Conveys that the client has to fulfill the intent.</p> </li> </ul>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-lex-dialog-state\"\
        },\
        \"slotToElicit\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>If the <code>dialogState</code> is <code>ElicitSlot</code>, returns the name of the slot for which Amazon Lex is eliciting a value.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-lex-slot-to-elicit\"\
        },\
        \"audioStream\":{\
          \"shape\":\"BlobStream\",\
          \"documentation\":\"<p>The audio version of the message to convey to the user.</p>\"\
        },\
        \"sessionId\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>A unique identifier for the session.</p>\",\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-lex-session-id\"\
        },\
        \"activeContexts\":{\
          \"shape\":\"ActiveContextsString\",\
          \"documentation\":\"<p>A list of active contexts for the session.</p>\",\
          \"jsonvalue\":true,\
          \"location\":\"header\",\
          \"locationName\":\"x-amz-lex-active-contexts\"\
        }\
      },\
      \"payload\":\"audioStream\"\
    },\
    \"RequestTimeoutException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"String\"}\
      },\
      \"documentation\":\"<p>The input speech is too long.</p>\",\
      \"error\":{\"httpStatusCode\":408},\
      \"exception\":true\
    },\
    \"ResponseCard\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"version\":{\
          \"shape\":\"String\",\
          \"documentation\":\"<p>The version of the response card format.</p>\"\
        },\
        \"contentType\":{\
          \"shape\":\"ContentType\",\
          \"documentation\":\"<p>The content type of the response.</p>\"\
        },\
        \"genericAttachments\":{\
          \"shape\":\"genericAttachmentList\",\
          \"documentation\":\"<p>An array of attachment objects representing options.</p>\"\
        }\
      },\
      \"documentation\":\"<p>If you configure a response card when creating your bots, Amazon Lex substitutes the session attributes and slot values that are available, and then returns it. The response card can also come from a Lambda function ( <code>dialogCodeHook</code> and <code>fulfillmentActivity</code> on an intent).</p>\"\
    },\
    \"SentimentLabel\":{\"type\":\"string\"},\
    \"SentimentResponse\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"sentimentLabel\":{\
          \"shape\":\"SentimentLabel\",\
          \"documentation\":\"<p>The inferred sentiment that Amazon Comprehend has the highest confidence in.</p>\"\
        },\
        \"sentimentScore\":{\
          \"shape\":\"SentimentScore\",\
          \"documentation\":\"<p>The likelihood that the sentiment was correctly inferred.</p>\"\
        }\
      },\
      \"documentation\":\"<p>The sentiment expressed in an utterance.</p> <p>When the bot is configured to send utterances to Amazon Comprehend for sentiment analysis, this field structure contains the result of the analysis.</p>\"\
    },\
    \"SentimentScore\":{\"type\":\"string\"},\
    \"String\":{\"type\":\"string\"},\
    \"StringMap\":{\
      \"type\":\"map\",\
      \"key\":{\"shape\":\"String\"},\
      \"value\":{\"shape\":\"String\"},\
      \"sensitive\":true\
    },\
    \"StringUrlWithLength\":{\
      \"type\":\"string\",\
      \"max\":2048,\
      \"min\":1\
    },\
    \"StringWithLength\":{\
      \"type\":\"string\",\
      \"max\":80,\
      \"min\":1\
    },\
    \"Text\":{\
      \"type\":\"string\",\
      \"max\":1024,\
      \"min\":1,\
      \"sensitive\":true\
    },\
    \"UnsupportedMediaTypeException\":{\
      \"type\":\"structure\",\
      \"members\":{\
        \"message\":{\"shape\":\"String\"}\
      },\
      \"documentation\":\"<p>The Content-Type header (<code>PostContent</code> API) has an invalid value. </p>\",\
      \"error\":{\"httpStatusCode\":415},\
      \"exception\":true\
    },\
    \"UserId\":{\
      \"type\":\"string\",\
      \"max\":100,\
      \"min\":2,\
      \"pattern\":\"[0-9a-zA-Z._:-]+\"\
    },\
    \"genericAttachmentList\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"GenericAttachment\"},\
      \"max\":10,\
      \"min\":0\
    },\
    \"listOfButtons\":{\
      \"type\":\"list\",\
      \"member\":{\"shape\":\"Button\"},\
      \"max\":5,\
      \"min\":0\
    }\
  },\
  \"documentation\":\"<p>Amazon Lex provides both build and runtime endpoints. Each endpoint provides a set of operations (API). Your conversational bot uses the runtime API to understand user utterances (user input text or voice). For example, suppose a user says \\\"I want pizza\\\", your bot sends this input to Amazon Lex using the runtime API. Amazon Lex recognizes that the user request is for the OrderPizza intent (one of the intents defined in the bot). Then Amazon Lex engages in user conversation on behalf of the bot to elicit required information (slot values, such as pizza size and crust type), and then performs fulfillment activity (that you configured when you created the bot). You use the build-time API to create and manage your Amazon Lex bot. For a list of build-time operations, see the build-time API, . </p>\"\
}\
";
}

@end
