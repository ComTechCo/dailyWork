#include "List_Operation.h"
#include <stdlib.h>
#include <stdio.h>
extern int Variate;
status initlist_Lnode(LNode **l, Minimum **p)
{
    *l=(LNode*)malloc(sizeof(LNode));
    *p=(Minimum*)malloc(sizeof(Minimum));
    if(!(*p) ) return ERROR;
    if(!(*l) ) return ERROR;
    (*l)->data=NO_DATA;
    (*l)->next=NULL;
    (*l)->Mark=NO_MARK;
    (*p)->data=NO_DATA;
    (*p)->next=NULL;
    (*p)->Num_Label=0;
    return OK;

}
status clearlist (LNode *l)
{
    LNode *p=l->next,*q;
    while(p)
    {
        q=p->next;
        free(p);
        p=q;
    }
    l->next = NULL;
    l->Mark=NO_MARK;
    return OK;
}
LNode* creatnode_LNode(LNode *l)
{
    LNode *copy_l;
    copy_l=l;
    while(copy_l->next)
    {
        copy_l=copy_l->next;
    }
    copy_l->next=(LNode*)malloc(sizeof(LNode));
    copy_l=copy_l->next;
    copy_l->Mark=NO_MARK;
    copy_l->next=NULL;
    return copy_l;
}
Minimum* creatnode_Minimum(Minimum *l)
{
    Minimum *copy_l;
    copy_l=l;
    while(copy_l->next)
    {
        copy_l=copy_l->next;
    }
    copy_l->next=(Minimum*)malloc(sizeof(Minimum));
    copy_l=copy_l->next;
    copy_l->next=NULL;
    copy_l->Num_Label=0;
    return copy_l;
}
void Delete_LNode(LNode *p)
{
    LNode *copy_p=p->next->next;
    free(p->next);
    p->next=copy_p;
}
void Delete_Minimum(Minimum *p)
{
    Minimum *copy_p=p->next->next;
    free(p->next);
    p->next=copy_p;
}
void _Printf_Data(LNode *l)
{
    LNode *copy_l=l;
    while(copy_l)
    {
        printf("%d ",copy_l->data);
        copy_l=copy_l->next;
    }
}
void _Printf_Data_Mini(Minimum *l)
{
    Minimum *copy_l=l;
    while(copy_l)
    {
        printf("%d",copy_l->data);
        copy_l=copy_l->next;
    }
}
void _Printf_Bits(LNode *l)
{
    LNode *copy_l=l;
    int i;
    while(copy_l)
    {
        printf("\n");
        for(i=0;i<Variate;i++)
        {
            printf("%d",copy_l->Bits[i]);
        }
        printf(" ");
        copy_l=copy_l->next;
    }
}
//比较函数，从链表第一个节点开始，遇到组号为0的节点从头开始查找是否有节点组号为1，
//若有判断是否为相邻项，标记两者为非本源项，并将不同的位置标记为 NONE
//判断相邻方法：利用二进制数组，如果只有一位不同，置位NONE，复制到一个新的节点;
void Compare_Func(LNode *be_compare,LNode *Columns_LNode)
{
    int i=0;
    LNode *copy_be_1=be_compare;
    LNode *copy_be_2=be_compare;
    LNode *copy_be_3=be_compare;
    for(i=0;i<Variate;i++)
    {
        while(copy_be_1)
        {
            if(copy_be_1->Group_Sequ==i)//找到了第一个组别为i的节点
            {
                copy_be_2=copy_be_1;//赋值
                while(copy_be_3)//从头开始查找组别为i+1的节点
                {
                    if(  (copy_be_3->Group_Sequ) ==(copy_be_2->Group_Sequ+1) )

                    {    //比较记录
                        Compare_record(copy_be_2,copy_be_3,Columns_LNode,i);
                    }
                    copy_be_3=copy_be_3->next;
                }
                copy_be_3=be_compare;//将copy_be_3置位头结点
            }
            copy_be_1=copy_be_1->next;//找下一个组别为i的节点
        }
        copy_be_1=be_compare;//将copy_be_1置位头结点
    }

}
void Compare_record(LNode *copy_be_2,LNode *copy_be_3,LNode *Columns_LNode,int group_num)
{
    int i,posion,close=0;
    LNode *p=Columns_LNode;
    for(i=0;i<Variate;i++)
    {
        if(copy_be_2->Bits[i]!=copy_be_3->Bits[i])
        {posion=i;close++;}
    }
    if(close==1)
    {
        if(p->Mark==NO_MARK)
        {
            for(i=0;i<Variate;i++)
            {
                p->Bits[i]=copy_be_2->Bits[i];
            }
            p->Bits[posion]=NONE;
            p->Mark=PRIME;
            p->Group_Sequ=group_num;
        }
        else
        {
            p=creatnode_LNode(Columns_LNode);
            for(i=0;i<Variate;i++)
            {
                p->Bits[i]=copy_be_2->Bits[i];
            }
            p->Bits[posion]=NONE;
            p->Mark=PRIME;
            p->Group_Sequ=group_num;
        }
        copy_be_2->Mark=NO_PRIME;
        copy_be_3->Mark=NO_PRIME;
    }

}
void Delete_Same_node(LNode *p)
{
    LNode *copy_p_1=p,*copy_p_2=p;
    while(copy_p_1)
    {
        copy_p_2=copy_p_1;
        while(copy_p_2->next)
        {

            if(Is_Same(copy_p_1,copy_p_2->next) )
            {
                Delete_LNode(copy_p_2);
            }
            else{copy_p_2=copy_p_2->next;}
        }
        copy_p_1=copy_p_1->next;
    }

}
int Is_Same(LNode *p2,LNode *p1)
{
    int i;
    for(i=0;i<Variate;i++)
    {
        if(p1->Bits[i]!=p2->Bits[i])
        {
            return 0;
        }
    }
    return 1;
}
void LabeL_Min_Essent(LNode *head_ESSENT_PRIME,Minimum *head_Mini)
{
    LNode *copy_head_ESSENT_PRIME=head_ESSENT_PRIME;
    Minimum *copy_head_Mini=head_Mini;
    while(copy_head_ESSENT_PRIME)
    {
        copy_head_Mini=head_Mini;
        while(copy_head_Mini)
        {
            if(Is_Include(copy_head_ESSENT_PRIME,copy_head_Mini))
            {
                copy_head_ESSENT_PRIME->Group_Sequ++;   //本质本源项包含最小项加一
                copy_head_Mini->Num_Label++;            //最小项被标记的次数加一
            }
            copy_head_Mini=copy_head_Mini->next;
        }
        copy_head_ESSENT_PRIME=copy_head_ESSENT_PRIME->next;
    }
}
int Is_Include(LNode *copy_head_ESSENT_PRIME,Minimum *copy_head_Mini)
{
    int i;
    for(i=0;i<Variate;i++)
    {
        if(copy_head_ESSENT_PRIME->Bits[i]!=NONE)
        {
            if(copy_head_ESSENT_PRIME->Bits[i]!=copy_head_Mini->Bits[i])
            {
                return 0;
            }
        }
    }
    return 1;
}
void clear_Label_Sequ(LNode *head_ESSENT_PRIME,Minimum *head_Mini)
{
    LNode *copy_head_ESSENT_PRIME=head_ESSENT_PRIME;
    Minimum *copy_head_Mini=head_Mini;
    while(copy_head_ESSENT_PRIME)
    {
        copy_head_ESSENT_PRIME->Group_Sequ=0;
        copy_head_ESSENT_PRIME=copy_head_ESSENT_PRIME->next;
    }
    while(copy_head_Mini)
    {
        copy_head_Mini->Num_Label=0;
        copy_head_Mini=copy_head_Mini->next;
    }
}
