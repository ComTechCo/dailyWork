#include "List_Operation.h"
#include "Input.h"
#include <stdio.h>
int Variate;
int int_power(int x,int n)
{
    int i,x_n=1;
    if(n==0) return 1;
    for(i=1;i<=n;i++)
    {
        x_n*=x;
    }
    return x_n;
}
//判断变量的个数
void Num_Variate(LNode *p)
{
    int max=0,i,x=2;
    LNode *copy_p;
    copy_p=p;
    while(copy_p)
    {
        if(copy_p->data>max)
        {
            max=copy_p->data;
        }
        copy_p=copy_p->next;
    }
    for(i=0;max>int_power(x,i);i++);
    Variate = i;
}
//把变量各个二进制位储存起来
void Reslove_LNode(LNode *p)
{
    int i,x=2,Num_1=0;
    LNode *copy_p=p;
    while(copy_p)
    {   for(i=0;i<Variate;i++)
        {
            if(int_power(x,i)&(copy_p->data) )
            {
                copy_p->Bits[i]=1;
                Num_1++;
            }
            else{copy_p->Bits[i]=0;}
        }
        copy_p->Group_Sequ=Num_1;
        Num_1=0;
        copy_p=copy_p->next;
    }
}
void Reslove_Mini(Minimum *p)
{
    int i,x=2;
    Minimum *copy_p=p;
    while(copy_p)
    {   for(i=0;i<Variate;i++)
        {
            if(int_power(x,i)&(copy_p->data) )
            {
                copy_p->Bits[i]=1;
            }
            else{copy_p->Bits[i]=0;}
        }
        copy_p->Num_Label=0;
        copy_p=copy_p->next;
    }
}
//用户输入最小最大值
void Receive(LNode **head_LNode,Minimum **head_Mini,int Num_min,int Num_Irelev)
{
    int i;
    initlist_Lnode(head_LNode,head_Mini);
    LNode *cur_LNode;
    Minimum  *cur_Minimum;
    (*head_LNode)->data=-1;
    for(i=1;i<=Num_min;i++)
    {
        if((*head_LNode)->data==-1)
        {
            scanf("%d",&((*head_LNode)->data)) ;
            (*head_Mini)->data=(*head_LNode)->data;
            (*head_LNode)->Mark=PRIME;
            continue;
        }
        else
        {
            cur_LNode=creatnode_LNode(*head_LNode);
            cur_Minimum=creatnode_Minimum(*head_Mini);
            scanf("%d",&(cur_LNode->data));
            cur_Minimum->data=cur_LNode->data;
            cur_LNode->Mark=PRIME;
        }


    }
    for(i=1;i<=Num_Irelev;i++)
    {
        cur_LNode=creatnode_LNode(*head_LNode);
        scanf("%d",&(cur_LNode->data));
        cur_LNode->Mark=PRIME;
    }
}
