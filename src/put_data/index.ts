import { DynamoDBClient } from '@aws-sdk/client-dynamodb';
import { DynamoDBDocumentClient, PutCommand } from '@aws-sdk/lib-dynamodb';

const dynamodbClient = new DynamoDBClient({
  region: 'ap-northeast-1',
});

const docClient = DynamoDBDocumentClient.from(dynamodbClient);

interface AppSyncEvent {
  arguments: {
    id: string;
    name: string;
  };
}

export const handler = async (event: AppSyncEvent): Promise<boolean> => {
  const {id, name} = event.arguments;

  const command = new PutCommand({
    TableName: 'my-dynamodb',
    Item: {
      id,
      name
    },
  });

  await docClient.send(command);

  return true;
};
