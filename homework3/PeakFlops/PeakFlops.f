





	!--------------------------------------------------------------------
	!
	!
	! PURPOSE
	!
	! This program measures Peak gigaflops on Xeon Phi 
	!
	! .. Parameters ..
	!  size	        	= Vector size 
	!  iter                 = number of iterations to do 
	! .. Scalars ..
	!  maxthreads   	= maximum number of threads 
	!  i                    = loop counter
	!  j                    = loop counter
	!  randnum              = random number generated from (0,1) uniform 
	!                       distribution
        ! start                 = start time of flop counting iterations
        ! finish                = end time of flop counting iterations 
	! .. Arrays ..
	!
	! .. Vectors ..
	! a(1:size)       = vector for doing addition
        ! b(1:size)       = one input vector
        ! c(1:size)       = second input vector
        !
	! REFERENCES
	! Gropp, Lusk and Skjellum, "Intel Xeon Phi Coprocessor Architecture and Tools:
        ! The Guid for Application Developers" MIT press (2014)
	!
	! ACKNOWLEDGEMENTS
	! The program below is based on a C version by ,
        ! given in Listing 4-1 of Intel Xeon Phi Coprocessor Architecture and Tools:
        ! The Guide for Application Developers 
	!
	! ACCURACY
	!		
	! ERROR INDICATORS AND WARNINGS
	!
	! FURTHER COMMENTS
	!
	!--------------------------------------------------------------------
	! External routines required
	! 
	! External libraries required
	! OpenMP library
        ! XeonPhi offload library
    	PROGRAM maxflops
    	USE omp_lib
    	!USE mic_lib 
    	IMPLICIT NONE

    	INTEGER(kind=4), PARAMETER 	:: size = 16
    	INTEGER(kind=4), PARAMETER  	:: iter = 48000000 
    	INTEGER(kind=4) 	        :: i,j,maxthreads
    	DOUBLE PRECISION 	       	:: randnum, gflop, gfloppersecond
    	DOUBLE PRECISION 	       	:: start, finish
    	DOUBLE PRECISION                :: a(1:size), b(1:size), c(1:size) 
   
    	!!DIR$ OFFLOAD BEGIN TARGET(mic)  
    	DO i=1,size
      	   CALL random_number(randnum)
      	   a(i)=randnum
    	END DO

    	DO i=1,size
      	   CALL random_number(randnum)
      	   b(i)=randnum
    	END DO

    	DO i=1,size
      	   CALL random_number(randnum)
      	   c(i)=randnum
    	END DO

   	! Warm up cache
   	!$OMP PARALLEL DO SCHEDULE(STATIC)
   	DO i=1,iter
           !DIR$ SIMD 
           DO j=1,size
    	       a(j)=b(j)*c(j)+a(j)
           END DO
   	END DO
   	!$OMP END PARALLEL DO

   	start = omp_get_wtime()
   	!$OMP PARALLEL DO SCHEDULE(static)
   	DO i=1,iter
           !DIR$ SIMD 
           DO j=1,size
     	      a(j)=b(j)*c(j)+a(j)
           END DO
   	END DO
   	!$OMP END PARALLEL DO
   	finish = omp_get_wtime()
   	gflop=2.0*size*iter/10.0**9
   	gfloppersecond=gflop/(finish-start)
   	maxthreads = omp_get_max_threads()

    	!!DIR$ END OFFLOAD
    	PRINT *, ' Maximum number of threads = '
        PRINT *, maxthreads
        PRINT *, ' 10^9 Floating point operations per second '	
        PRINT *, gfloppersecond
    	STOP
    	END PROGRAM maxflops

