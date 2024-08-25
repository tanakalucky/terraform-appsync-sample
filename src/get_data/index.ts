import { DynamoDBClient } from '@aws-sdk/client-dynamodb';
import { DynamoDBDocumentClient, ScanCommand } from '@aws-sdk/lib-dynamodb';

const dynamodbClient = new DynamoDBClient({
  region: 'ap-northeast-1',
});

const docClient = DynamoDBDocumentClient.from(dynamodbClient);

export const handler = async (): Promise<{ id: string; name: string }[]> => {
  const command = new ScanCommand({
    TableName: 'my-dynamodb',
  });

  const { Items } = await docClient.send(command);
  const items =
    Items?.map((item): { id: string; name: string } => {
      return {
        id: item.id ?? '',
        name: item.name ?? '',
      };
    }) ?? [];

  return items;
};
