

#include <stdio.h>
	__global__ void add(int* a, int* b, int* c, int n)
	{

	    int id = threadIdx.x;	    

	    if(id < n )
	        c[id] = a[id] + b[id];
	}


	int main(void) {
	    int n = 1000;

	    int* a;
	    int* b;
	    int* c;

	    size_t nbytes = n * sizeof(int);

	    cudaMallocManaged (&a, nbytes);
        cudaMallocManaged (&b, nbytes);
        cudaMallocManaged (&c, nbytes);
	   
	    for(int i = 0; i < n; i++)
	    {
	        a[i] = 1;
	        b[i] = 2;
	    }	    

        add<<<1,n>>>(a,b,c,n);
        

        cudaDeviceSynchronize();

        int sum = 0;
        for(int i = 0; i < n; i++)
        {
        	sum+=c[i];
        }
        printf("%d\n",sum);

        cudaFree(&a);
        cudaFree(&b);
        cudaFree(&c);

        return 0;



	}


