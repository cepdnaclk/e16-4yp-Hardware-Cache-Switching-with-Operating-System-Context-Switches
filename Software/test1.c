// #include <stdio.h>

int main()
{
  int a[2][2] = {
      {10, 10},
      {10, 10}};
  int b[2][2] = {
      {1, 1},
      {1, 1}};
  int row_count = sizeof(a) / sizeof(a[0]);
  int colum_count = sizeof(b[0]) / sizeof(b[0][0]);
  int out[2][2];
  int sum;
  for (int i = 0; i < row_count; i++)
  {
    for (int j = 0; j < colum_count; j++)
    {
      sum = 0;
      for (int k = 0; k < sizeof(a[0]) / sizeof(a[0][0]); k++)
      {
        sum += a[i][k] * b[k][j];
      }
      out[i][j] = sum;
    }
  }
  // for (int i = 0; i < row_count; i++)
  // {
  //   for (int j = 0; j < colum_count; j++)
  //   {
  //     printf("%d ", out[i][j]);
  //   }
  //   printf("\n");
  // }
  return out[0,0];
}
