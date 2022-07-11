#include <stdio.h>
#include <stdlib.h>
#include "Input.h"
#include "List_Operation.h"
#define TIMES_MAX 10
#define Num_columns 2
#define _Not_yet_Printf 0
#define _Have_Printf 1
extern int Variate;
typedef struct priority_element
{
    int Counter_Variate_Priority;
    int Variate_Priority;
}Priority_Element;
void Is_Label_1(LNode *Ultimate_List,Minimum *head_node_Minimum,LNode *head_ESSENT_PRIME);
void Least_Cover(LNode *Ultimate_List,Minimum *head_node_Minimum,LNode *head_ESSENT_PRIME);
void Print_Variate(LNode *Ultimate_List);
void Creat_Priority_Sheet(Priority_Element Priority_Sheet[]);
void Set_Priority_Mark(LNode *Ultimate_List,Priority_Element Priority_Sheet[]);
void Last_Operation(LNode *Ultimate_List);
int num_Essent_Prime=0;//本质本源项个数
int num_Prime=0;//非本质本源项个数
int main()
{
    int times,i,n;
    int Num_min[TIMES_MAX],Num_Irelev[TIMES_MAX];
    LNode *copy_head_LNode;
    LNode *copy_head_ESSENT_PRIME;
    LNode *head_LNode[TIMES_MAX];
    Minimum *head_Mini[TIMES_MAX];
    //定义优先级表
    Priority_Element   Priority_Sheet[Num_Bits];
    //为最小项创建一个头结点
    Minimum *head_node_Minimum;
    head_node_Minimum=(Minimum*)malloc(sizeof(Minimum));
    //列指针初始化
    int column=1;
    LNode *Columns_LNode[Num_columns];
    Columns_LNode[column]=(LNode*)malloc(sizeof(LNode));
    Columns_LNode[column]->next=NULL;
    Columns_LNode[column]->data=NO_DATA;
    Columns_LNode[column]->Mark=NO_MARK;
    Columns_LNode[!column]=(LNode*)malloc(sizeof(LNode));
    Columns_LNode[!column]->next=NULL;
    Columns_LNode[!column]->data=NO_DATA;
    Columns_LNode[!column]->Mark=NO_MARK;
    //本质本愿列初始化
    LNode *head_ESSENT_PRIME;
    head_ESSENT_PRIME=(LNode*)malloc(sizeof(LNode));
    head_ESSENT_PRIME->next=NULL;
    head_ESSENT_PRIME->data=NO_DATA;
    head_ESSENT_PRIME->Mark=NO_MARK;
    //最终链表初始化
    LNode *Ultimate_List;
    Ultimate_List=(LNode*)malloc(sizeof(LNode));
    Ultimate_List->next=NULL;
    Ultimate_List->data=NO_DATA;
    Ultimate_List->Mark=NO_MARK;
    Ultimate_List->Bits[0]=-1;
    //指针数组初始化
    for(i=0;i<TIMES_MAX;i++) head_LNode[i]=NULL;
    for(i=0;i<TIMES_MAX;i++) head_Mini[i]=NULL;
    printf("你想输入几次：");
    scanf("%d",&times);
    i=0;
    for(i=0;i<times;i++)
    {
        printf("请输入最小项个数，无关项个数：");
        scanf("%d %d",&Num_min[i],&Num_Irelev[i]);
        // 0 2 3 5 6 8 9 10 12 13 15
        Receive(&head_LNode[i],&head_Mini[i],Num_min[i],Num_Irelev[i]);
        Num_Variate(head_LNode[i]);
        Reslove_LNode(head_LNode[i]);
        Reslove_Mini(head_Mini[i]);
        //_Printf_Data(head_LNode[i]);
        //_Printf_Data_Mini(head_Mini[i]);
    }
    //传入函数之后会在column中生成新的本源项，然后我们查找head_LNode中的本质本源项，
    //并将其存入一个新的链表，循环将新的本源列合成下一个本源列,循环结束的条件是下一个本源列为空
    for(i=0;i<times;i++)
    {
        Num_Variate(head_LNode[i]);
        //各种初始化
        if(Num_min[i]==0)
        {
            printf("\n");
            printf("0");
            continue;
        }
        else if(Num_min[i]+Num_Irelev[i]==int_power(2,Variate))
        {
            printf("\n");
            printf("1");
            continue;
        }
        else if(Num_min[i]==1&&Num_Irelev[i]==0)
        {
            printf("\n");
            Print_Variate(head_LNode[i]);
        }
        else
        {
            Columns_LNode[column]->next=NULL;
            Columns_LNode[column]->data=NO_DATA;
            Columns_LNode[column]->Mark=NO_MARK;
            Columns_LNode[!column]->next=NULL;
            Columns_LNode[!column]->data=NO_DATA;
            Columns_LNode[!column]->Mark=NO_MARK;
            head_ESSENT_PRIME->next=NULL;
            head_ESSENT_PRIME->data=NO_DATA;
            head_ESSENT_PRIME->Mark=NO_MARK;
            Ultimate_List->next=NULL;
            Ultimate_List->data=NO_DATA;
            Ultimate_List->Mark=NO_MARK;
            Ultimate_List->Bits[0]=-1;

            num_Essent_Prime=0;//本质本源项个数置为零
            num_Prime=0;//非本质本源项个数置为零
            Compare_Func(head_LNode[i],Columns_LNode[!column]);
            copy_head_LNode=head_LNode[i];
            copy_head_ESSENT_PRIME=head_ESSENT_PRIME;
            while(copy_head_LNode)
            {
                if(copy_head_LNode->Mark==PRIME)//是本源项
                {
                    if(head_ESSENT_PRIME->Mark==NO_MARK)//判断头结点是否被标记
                    {
                        for(n=0;n<Variate;n++)
                        {
                            head_ESSENT_PRIME->Bits[n]=copy_head_LNode->Bits[n];
                            head_ESSENT_PRIME->Mark=PRIME;
                        }
                    }
                    else
                    {
                        copy_head_ESSENT_PRIME=creatnode_LNode(head_ESSENT_PRIME);//创建新的节点
                        for(n=0;n<Variate;n++)
                        {
                            copy_head_ESSENT_PRIME->Bits[n]=copy_head_LNode->Bits[n];
                        }

                    }
                }
                copy_head_LNode=copy_head_LNode->next;
            }
            if(Columns_LNode[!column]->Mark!=NO_MARK)//break;//退出循环条件
            {
                for(;;)
                {

                    Compare_Func(Columns_LNode[!column],Columns_LNode[column]);
                    copy_head_LNode=Columns_LNode[!column];
                    copy_head_ESSENT_PRIME=head_ESSENT_PRIME;
                    while(copy_head_LNode)
                    {
                        if(copy_head_LNode->Mark==PRIME)//是本质本源项
                        {
                            if(head_ESSENT_PRIME->Mark==NO_MARK)//判断头结点是否被标记
                            {
                                for(n=0;n<Variate;n++)
                                {
                                    head_ESSENT_PRIME->Bits[n]=copy_head_LNode->Bits[n];
                                    head_ESSENT_PRIME->Mark=PRIME;
                                }
                            }
                            else
                            {
                                copy_head_ESSENT_PRIME=creatnode_LNode(head_ESSENT_PRIME);//创建新的节点
                                for(n=0;n<Variate;n++)
                                {
                                    copy_head_ESSENT_PRIME->Bits[n]=copy_head_LNode->Bits[n];
                                }

                            }
                        }
                        copy_head_LNode=copy_head_LNode->next;
                    }
                    clearlist (Columns_LNode[!column]);
                    if(Columns_LNode[column]->Mark==NO_MARK)break;//退出循环条件
                    column=!column;

                }
            }

            Delete_Same_node(head_ESSENT_PRIME);
            clear_Label_Sequ(head_ESSENT_PRIME,head_Mini[i]);
            LabeL_Min_Essent(head_ESSENT_PRIME,head_Mini[i]);
            //循环判断哪个最小项只被标记了一次，循环将标记它的本质本源项复制到最终链表里
            //删除此本质本源项所包含的其他最小项,以及将此本质本愿项Group_Sequ置位0
            //重新标记新的本质本源项和最小项
            //判断包含最多最小项的本质本源项，如果两者包含的一样多，取第一个，复制到最终链表里，
            //删除此本质本源项所包含的其他最小项,（删除最小项的时候要注意头结点和尾节点的删除,
            //头结点用循环次数测试，尾节点用下一指针为空判断
            //以及将此本质本愿项Group_Sequ置位0
            //循环结束的条件是最小项列表为空，

            //为最小项创建一个头结点，初始化
            head_node_Minimum->data=-1;
            for(n=0;n<Variate;n++)
            {head_node_Minimum->Bits[n]=-1;}
            head_node_Minimum->Num_Label=0;
            head_node_Minimum->next=NULL;
            head_node_Minimum->next=head_Mini[i];
            Is_Label_1(Ultimate_List,head_node_Minimum,head_ESSENT_PRIME);//对本质本源项的处理
            Least_Cover(Ultimate_List,head_node_Minimum,head_ESSENT_PRIME);//求最小覆盖
            //写一个输出函数
            printf("\n");
            Creat_Priority_Sheet(Priority_Sheet);
            Set_Priority_Mark(Ultimate_List,Priority_Sheet);
            Last_Operation(Ultimate_List);
            printf("\n");
            //清空链表
            clearlist(head_LNode[i]);
            clearlist(Columns_LNode[!column] );
            clearlist(Columns_LNode[column]);
            clearlist(head_ESSENT_PRIME);
            clearlist(Ultimate_List);
        }

    }
    return 0;
}
//循环判断哪个最小项只被标记了一次，循环将标记它的本质本源项复制到最终链表里
//删除此本质本源项所包含的其他最小项,以及将此本质本愿项Group_Sequ置位0
void Is_Label_1(LNode *Ultimate_List,Minimum *head_node_Minimum,LNode *head_ESSENT_PRIME)
{
    LNode *copy_Ultimate_List=Ultimate_List;
    Minimum *copy_head_node_Minimum=head_node_Minimum;
    Minimum *copy_head_node_Minimum_2=head_node_Minimum;
    LNode *copy_head_ESSENT_PRIME=head_ESSENT_PRIME;
    int i;
    while(copy_head_node_Minimum)
    {
        if(copy_head_node_Minimum->Num_Label==1)//最小项只被标记了一次
        {
            num_Essent_Prime++;
            while(copy_head_ESSENT_PRIME)//判断哪一个本源项包含了只被标记一次的项
            {
                if(Is_Include(copy_head_ESSENT_PRIME,copy_head_node_Minimum))
                {
                    //将此本质本源项复制到最终链表
                    if(Ultimate_List->Bits[0]==-1)
                    {
                        for(i=0;i<Variate;i++)
                        {
                            Ultimate_List->Bits[i]=copy_head_ESSENT_PRIME->Bits[i];

                        }
                    }
                    else
                    {
                        copy_Ultimate_List=creatnode_LNode(Ultimate_List);
                        for(i=0;i<Variate;i++)
                        {
                            copy_Ultimate_List->Bits[i]=copy_head_ESSENT_PRIME->Bits[i];

                        }
                    }
                    //从头开始判断此本质本源项还包括哪些最小项并删除;
                    while(copy_head_node_Minimum_2)
                    {
                        if(!copy_head_node_Minimum_2->next)
                            break;
                        if(Is_Include(copy_head_ESSENT_PRIME,copy_head_node_Minimum_2->next))
                        {
                            Delete_Minimum(copy_head_node_Minimum_2);
                        }
                        else
                        {
                            copy_head_node_Minimum_2=copy_head_node_Minimum_2->next;
                        }
                    }

                    copy_head_node_Minimum_2=head_node_Minimum;
                    copy_head_ESSENT_PRIME=head_ESSENT_PRIME;
                    break;

                }
                else{copy_head_ESSENT_PRIME=copy_head_ESSENT_PRIME->next;}
            }
            copy_head_node_Minimum=head_node_Minimum->next;
        }
        else{copy_head_node_Minimum=copy_head_node_Minimum->next;}
    }

}
//重新标记新的本质本源项和最小项
//判断包含最多最小项的本质本源项，如果两者包含的一样多，取第一个，复制到最终链表里，
//删除此本质本源项所包含的其他最小项,（删除最小项的时候要注意头结点和尾节点的删除,
//头结点用循环次数测试，尾节点用下一指针为空判断
//以及将此本质本愿项Group_Sequ置位0
//循环结束的条件是最小项列表为空，

//寻求最小覆盖
void Least_Cover(LNode *Ultimate_List,Minimum *head_node_Minimum,LNode *head_ESSENT_PRIME)
{
    LNode *copy_Ultimate_List=Ultimate_List;
    Minimum *copy_head_node_Minimum=head_node_Minimum;
    LNode *copy_head_ESSENT_PRIME=head_ESSENT_PRIME;
    int i;
    LNode *Max_Group_Sequ_ESSENT_PRIME=head_ESSENT_PRIME;
    while(head_node_Minimum->next)//最小项链表中还有最小项
    {
        clear_Label_Sequ(head_ESSENT_PRIME,head_node_Minimum);//清楚标记
        LabeL_Min_Essent(head_ESSENT_PRIME,head_node_Minimum);//重新标记
        copy_Ultimate_List=Ultimate_List;
        copy_head_node_Minimum=head_node_Minimum;
        copy_head_ESSENT_PRIME=head_ESSENT_PRIME;
        //寻找包含最多最小项的本质本源项
        while(copy_head_ESSENT_PRIME)
        {
            if( (copy_head_ESSENT_PRIME->Group_Sequ) > (Max_Group_Sequ_ESSENT_PRIME->Group_Sequ) )
            {
                Max_Group_Sequ_ESSENT_PRIME=copy_head_ESSENT_PRIME;
            }
            copy_head_ESSENT_PRIME=copy_head_ESSENT_PRIME->next;
        }
        //将此本质本源项复制到最终链表
        if(Ultimate_List->Bits[0]==-1)
        {
            for(i=0;i<Variate;i++)
            {
                Ultimate_List->Bits[i]=Max_Group_Sequ_ESSENT_PRIME->Bits[i];

            }
            num_Prime++;
        }
        else
        {
            copy_Ultimate_List=creatnode_LNode(Ultimate_List);
            for(i=0;i<Variate;i++)
            {
                copy_Ultimate_List->Bits[i]=Max_Group_Sequ_ESSENT_PRIME->Bits[i];

            }
            num_Prime++;
        }
        while(copy_head_node_Minimum->next)

        {

            if(Is_Include(Max_Group_Sequ_ESSENT_PRIME,copy_head_node_Minimum->next))
            {

                Delete_Minimum(copy_head_node_Minimum);
                copy_head_node_Minimum=head_node_Minimum;

            }
            else
            {
                copy_head_node_Minimum=copy_head_node_Minimum->next;
            }
        }
    }
}
//打印ABCD
void Print_Variate(LNode *Ultimate_List)
{
    LNode *copy_Ultimate_List=Ultimate_List;
    char a='A';
    char copy_a=a;
    int copy_Variate=Variate;
    while(copy_Variate)
    {
        if(copy_Ultimate_List->Bits[copy_Variate-1]==NONE)
        {
            copy_Variate--;
            copy_a++;
        }
        else if(copy_Ultimate_List->Bits[copy_Variate-1]==1)
        {
            copy_Variate--;
            printf("%c",copy_a);
            copy_a++;
        }
        else if(copy_Ultimate_List->Bits[copy_Variate-1]==0)
        {
            copy_Variate--;
            printf("%c",copy_a);
            printf("\'");
            copy_a++;
        }
    }

}
//完成对输出顺序的控制
//对每一个变量位创建一个优先级表，优先级大的输出
//变量位             优先级
//NONE                 0
//第一位反变量         1
//第一位正变量         2
//之后每一位反变量    前面所有变量位正变量优先级之和+1
//之后每一位正变量    这一位反变量优先级+1
void Creat_Priority_Sheet(Priority_Element Priority_Sheet[])
{
    //最多10变量
    int i,n,sum;
    Priority_Sheet[0].Counter_Variate_Priority=1;
    Priority_Sheet[0].Variate_Priority=2;
    for(i=1;i<Num_Bits;i++)
    {
        n=0;
        sum=0;
        for(;n<i;n++)
        {
            sum+=Priority_Sheet[n].Variate_Priority;
        }
        Priority_Sheet[i].Counter_Variate_Priority=sum+1;
        Priority_Sheet[i].Variate_Priority=2*Priority_Sheet[i].Counter_Variate_Priority;//A>A'BCDE....
    }


}
//int data;//对于最终项来说它是优先级大小;
//char Bits[Num_Bits];
//char Group_Sequ;
//char Mark;//_Not_yet_Printf 还未打印输出   _Have_Printf已经输出过
//为最终项设置优先级及输出标志//
void Set_Priority_Mark(LNode *Ultimate_List,Priority_Element Priority_Sheet[])
{
    LNode *copy_Ultimate_List=Ultimate_List;
    int i;
    while(copy_Ultimate_List)
    {
        copy_Ultimate_List->data=0;
        for(i=0;i<Variate;i++)
        {
            if(copy_Ultimate_List->Bits[i]==NONE)
            {
                (copy_Ultimate_List->data)+=0;
            }
            else if(copy_Ultimate_List->Bits[i]==1)
            {
                (copy_Ultimate_List->data)+=Priority_Sheet[i].Variate_Priority;
            }
            else if(copy_Ultimate_List->Bits[i]==0)
            {
                (copy_Ultimate_List->data)+=Priority_Sheet[i].Counter_Variate_Priority;
            }
        }
        copy_Ultimate_List->Mark=_Not_yet_Printf;
        copy_Ultimate_List=copy_Ultimate_List->next;
    }


}
//最后一步，先判断最终项是否被输出，未被输出则输出最终项中优先级最大的一项，
//循环结束条件是num_Essent_Prime本质本源项个数本质本源项输出完毕，然后是本源项最终项全部被输出过
void Last_Operation(LNode *Ultimate_List)
{
    LNode *copy_Ultimate_List=Ultimate_List;
    LNode *copy_Ultimate_List_2=Ultimate_List;
    LNode *copy_Ultimate_List_3=Ultimate_List;
    LNode *Max_Priority=Ultimate_List;
    int i,n;
    int copy_num_Prime=0;
    for(i=1;i<=num_Essent_Prime;i++)
    {
        for(n=1;n<=num_Essent_Prime;n++)//寻找最大优先级
        {
            if(copy_Ultimate_List->Mark==_Not_yet_Printf)
            {
                if(  (copy_Ultimate_List->data) >(Max_Priority->data)  )
                {
                    Max_Priority=copy_Ultimate_List;
                }

            }
            copy_Ultimate_List=copy_Ultimate_List->next;

        }
        Max_Priority->Mark=_Have_Printf;
        Print_Variate(Max_Priority);
        if( (copy_Ultimate_List!=NULL )||(i!=num_Essent_Prime) )
            printf("+");
        //为Max_Priority重新设置一个没有被输出过的新的初始项
        copy_Ultimate_List=Ultimate_List;
        for(n=1;n<=num_Essent_Prime;n++)
        {
            if(copy_Ultimate_List->Mark==_Not_yet_Printf)
            {
                Max_Priority=copy_Ultimate_List;
                break;
            }
            else{copy_Ultimate_List=copy_Ultimate_List->next;}
        }
        copy_Ultimate_List=Ultimate_List;//重新寻找最大优先级


    }//完成对本质本源项的输出
    for(n=1;n<=num_Essent_Prime;n++)
    {
        copy_Ultimate_List_2=copy_Ultimate_List_2->next;//记录非本质本源项的第一项
    }
    if(copy_Ultimate_List_2!=NULL)
    {
        copy_Ultimate_List_3=copy_Ultimate_List_2;
        Max_Priority=copy_Ultimate_List_3;
        for(;;)
        {
            while(copy_Ultimate_List_3)//寻找最大优先级
            {
                if(copy_Ultimate_List_3->Mark==_Not_yet_Printf)
                {
                    if(  (copy_Ultimate_List_3->data) >(Max_Priority->data)  )
                    {
                        Max_Priority=copy_Ultimate_List_3;
                    }
                }
                copy_Ultimate_List_3=copy_Ultimate_List_3->next;

            }
            Max_Priority->Mark=_Have_Printf;
            copy_num_Prime++;
            Print_Variate(Max_Priority);
            if(copy_num_Prime<num_Prime)
                printf("+");
            //为Max_Priority重新设置一个没有被输出过的新的初始项
            copy_Ultimate_List_3=copy_Ultimate_List_2;
            while(copy_Ultimate_List_3)
            {
                if(copy_Ultimate_List_3->Mark==_Not_yet_Printf)
                {
                    Max_Priority=copy_Ultimate_List_3;
                    break;
                }
                else{copy_Ultimate_List_3=copy_Ultimate_List_3->next;}
            }
            if(Max_Priority->Mark==_Have_Printf)break;
            copy_Ultimate_List_3=copy_Ultimate_List_2;//重新寻找最大优先级
        }
    }
}
