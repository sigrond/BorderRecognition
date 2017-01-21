#include "mex.h"
#include "HandlesStructures.hpp"
#include <cstdio>

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
	float* P2;
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
	
	int dimsIC[2]={11,3};/**< \todo wczytywać wartości z handles */
	plhs[0]=mxCreateNumericArray(2,dimsIC,mxSINGLE_CLASS,mxREAL);
	
	P2=(float*)mxGetPr(prhs[0]);
	int P2_size=mxGetN(prhs[0])*mxGetM(prhs[0]);
	printf("P2_size:%d\n",P2_size);
	
	HandlesStructures S;
	
	mxArray* tmp;
    mxArray* tmp2;
    int tmpb=mxIsStruct(prhs[1]);
    printf("mxIsStruct:%d\n",tmpb);
    if(!tmpb)
    {
        printf("2nd argument must be a struct\n");
        return;
    }
    tmp=mxGetField(prhs[1],0,"shX");//handles.shX
    S.shX=(float)mxGetScalar(tmp);
    printf("S.shX:%f\n",S.shX);
    tmp=mxGetField(prhs[1],0,"shY");
    S.shY=(float)mxGetScalar(tmp);
    printf("S.shY:%f\n",S.shY);
    tmp=mxGetField(prhs[1],0,"S");//handles.S
    tmp2=mxGetField(tmp,0,"D");//handles.S.D
    S.D=(float)mxGetScalar(tmp2);
    tmp2=mxGetField(tmp,0,"efD");
    S.efD=(float)mxGetScalar(tmp2);
    printf("S.D.efD:%f\n",S.efD);
    tmp2=mxGetField(tmp,0,"R");
    S.R1=(float)((double*)mxGetPr(tmp2))[0];
    S.R2=(float)((double*)mxGetPr(tmp2))[1];
    printf("S.R1:%f,S.R2:%f\n",S.R1,S.R2);
    tmp2=mxGetField(tmp,0,"g");
    S.g=(float)mxGetScalar(tmp2);
    tmp2=mxGetField(tmp,0,"l1");
    S.l1=(float)mxGetScalar(tmp2);
    printf("S.l1: %f\n",S.l1);//eL jeden !!!
    tmp2=mxGetField(tmp,0,"ll");
    S.ll=(float)mxGetScalar(tmp2);
    printf("S.ll: %f\n",S.ll);//eL eL !!!
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
    printf("S.Pk:(%f, %f, %f)\n",S.Pk.x,S.Pk.y,S.Pk.z);
    tmp2=mxGetField(tmp,0,"m2");
    S.m2=(float)mxGetScalar(tmp2);
    printf("S.m2:%f\n",S.m2);
	
	
}