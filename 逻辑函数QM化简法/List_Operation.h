#ifndef SIMPLEPLAYGROUND_LIST_OPERATION_H
#define SIMPLEPLAYGROUND_LIST_OPERATION_H
typedef char status;
#define Num_Bits 10
#define FALSE 0
#define TRUE 1
#define OK 1
#define ERROR 0
#define INFEASIBLE -1
#define OVERFLOW -2
//最小项 无关节点数据
#define NONE 2
//标记
#define NO_PRIME 0//非本源项
#define PRIME 1//本源项
#define NO_MARK -1
#define NO_DATA -1
#ifndef LIST_OPRATION_H
#define LIST_OPRATION_H
typedef struct Lnode
{
    int data;
    char Bits[Num_Bits];
    char Group_Sequ;//对于本质本源项来说它是包含的最小项个数
    char Mark;
    struct Lnode *next;
}LNode;
//最小项数据
typedef struct MInimum
{
    int data;
    char Bits[Num_Bits];
    char Num_Label;
    struct MInimum *next;
}Minimum;
#endif // LIST_OPRATION_H

//初始化
status initlist_Lnode(LNode **l,Minimum **p);
status clearlist (LNode *l);
LNode *creatnode_LNode(LNode *l);
Minimum *creatnode_Minimum(Minimum *l);
void _Printf_Data(LNode *l);
void _Printf_Bits(LNode *l);
void _Printf_Data_Mini(Minimum *l);
//比较函数，从链表第一个节点开始，遇到组号为0的节点从头开始查找是否有节点组号为1，
//若有判断是否为相邻项，标记两者为非本源项，并将不同的位置标记为 NONE
//判断相邻方法：利用二进制数组，如果只有一位不同，置位NONE，复制到一个新的节点;
void Compare_Func(LNode *be_compare,LNode *Columns_LNode);
void Compare_record(LNode *copy_be_2,LNode *copy_be_3,LNode *Columns_LNode,int group_num);
void Delete_LNode(LNode *p);
void Delete_Same_node(LNode *p);
int Is_Same(LNode *p2,LNode *p1);
void LabeL_Min_Essent(LNode *d_ESSENT_PRIME,Minimum *head_Mini);
int Is_Include(LNode *copy_head_ESSENT_PRIME,Minimum *copy_head_Mini);
void clear_Label_Sequ(LNode *head_ESSENT_PRIME,Minimum *head_Mini);
void Delete_Minimum(Minimum *p);

#endif //SIMPLEPLAYGROUND_LIST_OPERATION_H
