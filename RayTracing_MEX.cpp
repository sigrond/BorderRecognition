#include "mex.h"
#include "HandlesStructures.hpp"
#include <cstdio>
#include "float3.hpp"

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
	float* P2p;
	float* P;
	
	if(nrhs<2)
    {
        printf("not enough arguments\n");
        return;
    }
	
	if(nlhs<1)
    {
    	printf("not enough outputs, function returns P\n");
    	return;
    }
	
	int dimsIC[2]={11,3};
	plhs[0]=mxCreateNumericArray(2,dimsIC,mxSINGLE_CLASS,mxREAL);
	
	P2p=(float*)mxGetPr(prhs[0]);
	int P2_size=mxGetN(prhs[0])*mxGetM(prhs[0]);
	#ifdef DEBUG
	printf("P2_size:%d\n",P2_size);
	#endif
	
	HandlesStructures S;
	
	mxArray* tmp;
    mxArray* tmp2;
    int tmpb=mxIsStruct(prhs[1]);
	#ifdef DEBUG
    printf("mxIsStruct:%d\n",tmpb);
	#endif
    if(!tmpb)
    {
        printf("2nd argument must be a struct\n");
        return;
    }
    tmp=mxGetField(prhs[1],0,"shX");//handles.shX
    S.shX=(float)mxGetScalar(tmp);
	#ifdef DEBUG
    printf("S.shX:%f\n",S.shX);
	#endif
    tmp=mxGetField(prhs[1],0,"shY");
    S.shY=(float)mxGetScalar(tmp);
	#ifdef DEBUG
    printf("S.shY:%f\n",S.shY);
	#endif
    tmp=mxGetField(prhs[1],0,"S");//handles.S
    tmp2=mxGetField(tmp,0,"D");//handles.S.D
    S.D=(float)mxGetScalar(tmp2);
    tmp2=mxGetField(tmp,0,"efD");
    S.efD=(float)mxGetScalar(tmp2);
	#ifdef DEBUG
    printf("S.D.efD:%f\n",S.efD);
	#endif
    tmp2=mxGetField(tmp,0,"R");
    S.R1=(float)((double*)mxGetPr(tmp2))[0];
    S.R2=(float)((double*)mxGetPr(tmp2))[1];
	#ifdef DEBUG
    printf("S.R1:%f,S.R2:%f\n",S.R1,S.R2);
	#endif
    tmp2=mxGetField(tmp,0,"g");
    S.g=(float)mxGetScalar(tmp2);
    tmp2=mxGetField(tmp,0,"l1");
    S.l1=(float)mxGetScalar(tmp2);
	#ifdef DEBUG
    printf("S.l1: %f\n",S.l1);//eL jeden !!!
	#endif
    tmp2=mxGetField(tmp,0,"ll");
    S.ll=(float)mxGetScalar(tmp2);
	#ifdef DEBUG
    printf("S.ll: %f\n",S.ll);//eL eL !!!
	#endif
    tmp2=mxGetField(tmp,0,"lCCD");
    S.lCCD=(float)mxGetScalar(tmp2);
    tmp2=mxGetField(tmp,0,"CCDPH");
    S.CCDPH=(float)mxGetScalar(tmp2);
    tmp2=mxGetField(tmp,0,"CCDPW");
    S.CCDPW=(float)mxGetScalar(tmp2);
    tmp2=mxGetField(tmp,0,"PixSize");
    S.PixSize=(float)mxGetScalar(tmp2);
    tmp2=mxGetField(tmp,0,"CCDH");
    S.CCDH=(float)mxGetScalar(tmp2);
    tmp2=mxGetField(tmp,0,"CCDW");
    S.CCDW=(float)mxGetScalar(tmp2);
    tmp2=mxGetField(tmp,0,"Pk");
    S.Pk.x=(float)((double*)mxGetPr(tmp2))[0];
    S.Pk.y=(float)((double*)mxGetPr(tmp2))[1];
    S.Pk.z=(float)((double*)mxGetPr(tmp2))[2];
	#ifdef DEBUG
    printf("S.Pk:(%f, %f, %f)\n",S.Pk.x,S.Pk.y,S.Pk.z);
	#endif
    tmp2=mxGetField(tmp,0,"m2");
    S.m2=(float)mxGetScalar(tmp2);
	#ifdef DEBUG
    printf("S.m2:%f\n",S.m2);
	#endif
	
	
	float3 P2;
	P2.x=P2p[0];
	P2.y=P2p[1];
	P2.z=P2p[2];
	
	
	S.Cs1  = S.l1 - S.R1 + S.g;         
	S.Cs2  = S.Cs1 + S.ll + 2*S.R2;
	
	float3 P1 = S.Pk;
	
	float3 v = (P2 - P1)/norm(P2 - P1);
	
}