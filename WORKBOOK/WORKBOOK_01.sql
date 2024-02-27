/*
 * SELECT(조회)
 * 
 * -지정된 테이블에서 원하는 데이터를 선택해서 조회하는 SQL
 * 
 * -작성된 구문에 맞는 행, 열 데이터가 조회됨
 * ->조회된 기ㅕㄹ과 행의 집합 = RESULT SET(결과 집합)
 * 
 * -RESULT SET은 -행 이상이 포함될 수 있다
 * ->조건에 맞는 행이 없을 수도 있기 때문에
 * 
 * */
 --EMPLOYEE테이블에서 모든 행의 사번(EMP_ID),이름(EMP_NAME),급여(SALARY) 조회


/*[SELECT 작성법 -1(기초)]
 * SELECT 컬럼명, 컬럼명, ...
 * FROM 테이블명;
 *  
 * ->지정된 테이블에서 모든행의 컬럼명이 일치하는 컬럼 값 조회
 * 
 */


 SELECT EMP_ID, EMP_NAME, SALARY FROM EMPLOYEE;

---EMPLOYEE테이블에서 모든행의 이름, 입사일 조회
SELECT EMP_ID, HIRE_DATE FROM EMPLOYEE;


--EMPLOYEE테이블의 모든행 모든컬럼 조회
--asterisK(*) : 모든, 포함하다 뜻을 나타내는 기호
SELECT * FROM EMPLOYEE;

--DEPARTMENT 테이블의 부서코드, 부서명 조회
 
SELECT DEPT_ID, DEPT_TITLE FROM DEPARTMENT;

SELECT * FROM DEPARTMENT;

-----------------------------------------------------------

/*컬럼값 산술연산*/


--컬럼값: 행과열이 교차되는 테이블의 한칸에 작성된 값

--SELECT문 작성시
--컬럼명에 산술연산을 직접 작성하면 조회결과에 연산결과 반영되어 조회됨

--임포로이테이블에서 모든사원의 이름 급여 급여+100만조회

SELECT EMP_NAME, SALARY, SALARY+1000000
FROM EMPLOYEE;

SELECT EMP_ID, EMP_NAME, SALARY*12 
FROM EMPLOYEE;

--------------------------------------------------------------

/* SYSDATE, SYSTIMESTAMP */
-- (시스템이 나타내고 있는) 현재 시간

-- SYSDATE      : 년월일시분초
-- SYSTIMESTAMP : 년월일시분초,MS+지역


/* DUAL(DUmmy tAbLe) 테이블 */
-- 가짜 테이블(임시 테이블)
-- 실존하는 테이블이 아님
-- 테이블 데이터가 아닌 단순 데이터 조회 시 사용

SELECT SYSDATE, SYSTIMESTAMP 
FROM DUAL;



/* 날짜 데이터 연산하기 (+, - 만 가능!)  
 * -->+1 ==1일추가
 * -->-1 ==1일 감소
 * */

--어제,현재시간, 내일,모레 조회

SELECT SYSDATE -1, SYSDATE, SYSDATE +1, SYSDATE+2
FROM DUAL; 

--현재 시간 , 한 시간 후 , 1분 후  10초 후 

SELECT SYSDATE, SYSDATE+1/24, SYSDATE+1/24/60, SYSDATE+10/24/60/60 
FROM DUAL;


/*날짜 끼리 연산하기*/

--TO_DATE('문자열', '패턴')
--'문자열'을 '패턴'형태로 해석해서 DATE 타입으로 변경하는 함수

SELECT '2024-02-26', TO_DATE('2024-02-26', 'YYYY-MM-DD')
FROM DUAL;

SELECT TO_DATE('2024-02-26', 'YYYY-MM-DD') - TO_DATE('2024-02-25','YYYY-MM-DD')
FROM DUAL;

SELECT SYSDATE - TODATE('2024-02-25', 'YYYY-MM-DD')
FROM DUAL;

---EMPLOYEE 테이블에서 모든 사원의 이름 입사일 근무 일수 (현재시간-입사일)

SELECT EMP_NAME , HIRE_DATE ,SYSDATE -HIRE_DATE 
FROM EMPLOYEE;


SELECT CEIL(( SYSDATE - TO_DATE('1991-05-25', 'YYYY-MM-DD'))/365)
FROM DUAL;






-------------------------------------------------------------

/* 컬럼명 별칭 지정하기 */

-- 별칭 지정 방법
-- 1) 컬럼명 AS 별칭   :  문자O, 띄어쓰기 X, 특수문자 X
-- 2) 컬럼명 AS "별칭" : 	문자O, 띄어쓰기 O, 특수문자 O
-- 3) 컬럼명 별칭      : 	문자O, 띄어쓰기 X, 특수문자 X
-- 4) 컬럼명 "별칭"    :  문자O, 띄어쓰기 O, 특수문자 O

-- "" 의미 ("" 사이 글자 그대로 인식)
-- 1) 대/소문자 구분
-- 2) 특수문자, 띄어쓰기 인식

-- ORACLE에서 문자열은 '' 



SELECT CEIL( (SYSDATE - TO_DATE('1990-01-16', 'YYYY-MM-DD')) / 365 )
FROM DUAL;


SELECT EMP_ID AS 사번,
       EMP_NAME AS "사원 이름",
       SALARY *12 "연봉(급여*12)"
FROM EMPLOYEE;



----------------------------------------------------------------

/*연결 연산자(||)*/

--문자열 이어쓰기(+로 연결X)

SELECT EMP_ID || EMP_NAME
FROM EMPLOYEE;



----------------------------------

/*컬럼명 자리에 리터럴 직접 작성*/
--조회 결과 (RESULT SET)의 모든 행에 컬럼명 자리에 작성한 리터럴 값이 추가됨

SELECT  EMP_NAME, SALARY, '원',100,SYSDATE
FROM EMPLOYEE; 
 
---------------------------------------

/*DISTINCT(별개의 , 전혀다른)*/

--조회 결과 집합(RESULT SET)에 지정된 컬럼의 값이 중복되는 경우 이를 한번만 표현

--EMPOLYEE테이블에서 모든 사원의 부서 코드 조회
SELECT DEPT_CODE
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서
-- 사원이 있는 부서코드만 조회

-- SELECT * FROM DEPARTMENT;

SELECT DISTINCT  DEPT_CODE FROM EMPLOYEE;

--EMPLOYEE테이블에 존재하는 직급 코드의 종류 조회




-----------------------------------------------------------------


/******************/
/**** WHERE 절 ****/
/******************/

-- 테이블에서 조건을 충족하는 행을 조회할 때 사용
-- WHERE절에는 조건식(true/false)만 작성

-- 비교 연산자 : >, <, >=, <=, = (같다), !=, <> (같지 않다)
-- 논리 연산자 : AND, OR, NOT


/* [SELECT 작성법 - 2]
 * 
 * SELECT 컬럼명, 컬럼명, ...
 * FROM 테이블명
 * WHERE 조건식;
 * 
 * -> 지정된 테이블 모든 행에서 
 *   컬럼명이 일치하는 컬럼 값 조회
 * */


-- EMPLOYEE 테이블에서
-- 급여가 300만원을 초과하는 사원의
-- 사번, 이름, 급여, 부서코드 조회

/*3*/ SELECT EMP_ID, EMP_NAME, SALARY, DEPT_CODE
/*1*/ FROM EMPLOYEE
/*2*/ WHERE SALARY > 3000000;

/* FROM절에 지정된 테이블에서 
 * WHERE절로 행을 먼저 추려내고, 추려진 결과 행들 중에서 
 * SELECT절에 원하는 컬럼만 조회*/
   

-- EMPLOYEE 테이블에서 연봉이 5천만원 이하인 사원의
-- 사번, 이름, 연봉 조회
/*3*/ SELECT EMP_ID, EMP_NAME, SALARY * 12 연봉
/*1*/ FROM EMPLOYEE 
/*2*/ WHERE SALARY * 12 <= 50000000;

-- EMPLOYEE 테이블에서
-- 부서코드가 'D9'이 아닌 사원의
-- 이름, 부서코드, 전화번호 조회

SELECT EMP_NAME, DEPT_CODE, PHONE
FROM EMPLOYEE
WHERE DEPT_CODE !='D9';



----------------------
/* NULL 비교하기 */
----------------------
--  컬럼명 = NULL  / 컬럼명 != NULL   (X)
  --> =, !=, < 등의 비교 연산자는 값을 비교하는 연산자!!
  --> DB에서 NULL은 값 X, 저장된 값이 없다라는 의미!!!

-- 컬럼명 IS NULL  /  컬럼명 IS NOT NULL  (O)
  --> 컬럼 값이 존재하지 않는 경우 / 존재하는 경우


-- EMPLOYEE 테이블에서 DEPT_CODE가 "없는" 사원 조회
SELECT EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL; -- 2행

-- EMPLOYEE 테이블에서 DEPT_CODE가 "있는" 사원 조회
SELECT EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL; -- 21행

----------------------------------------------------------------------


/* 논리 연산자 사용(AND, OR) */

-- EMPLOYEE 테이블에서
-- 부서 코드가 'D6'인 사원 중
-- 급여가 300만을 초과하는 사원의
-- 이름, 부서코드, 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6' AND SALARY > 3000000;

-- EMPLOYEE 테이블에서
-- 급여가 300만 이상, 500만 이하인 사원의
-- 사번, 이름, 급여 조회
SELECT EMP_ID, EMP_NAME, SALARY
FROM   EMPLOYEE
WHERE  SALARY >= 3000000 
AND    SALARY <= 5000000; -- 6행


-- EMPLOYEE 테이블에서
-- 급여가 300만 미만 또는 500만 초과인 사원의
-- 사번, 이름, 급여 조회
SELECT EMP_ID, EMP_NAME, SALARY
FROM   EMPLOYEE
WHERE  SALARY < 3000000 
OR    SALARY > 5000000; -- 17행


/* 컬럼명 BETWEEN (A) AND (B)  */
--  컬럼의 값이 A 이상 B 이하면 TRUE
SELECT EMP_ID, EMP_NAME, SALARY
FROM   EMPLOYEE
WHERE SALARY BETWEEN 3000000 AND 5000000; -- 6행


/* 컬럼명 NOT BETWEEN (A) AND (B)  */
--  컬럼의 값이 A 이상 B 이하면 FALSE
   --> A 미만 또는 B 초과 시 TRUE
SELECT EMP_ID, EMP_NAME, SALARY
FROM   EMPLOYEE
WHERE SALARY NOT BETWEEN 3000000 AND 5000000; 


SELECT EMP_NAME, HIRE_DATE 
FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN 
     TO_DATE('2000-01-01','YYYY-MM-DD') 
     AND
     TO_DATE('2000-12-31','YYYY-MM-DD');
    
-------------------------------------------------------------------------
    
   
--EMPLOYEE테이블에서 부서코드가'D5', 'D6','D9'인 사원의 이름, 부서코드, 급여 조회
    
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM  EMPLOYEE
WHERE  DEPT_CODE = 'D5'
       OR DEPT_CODE ='D6' 
       OR DEPT_CODE = 'D9';
      

 /*************************************/
/* 컬럼명 IN (값1, 값2, 값3, ....)   */
/*************************************/

-- 컬럼의 값이 () 내 값과 일치하면 TRUE

-- EMPLOYEE 테이블에서 
-- 부서코드가  'D5', 'D6', 'D9'인 사원의
-- 이름, 부서코드, 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D5', 'D6', 'D9'); -- 12행



/*************************************/
/* 컬럼명 NOT IN (값1, 값2, 값3, ....)   */
/*************************************/

-- 컬럼의 값이 () 내 값과 일치하면 FALSE
 --> 컬럼의 값이 () 내 값과 일치하지 않으면 TRUE


-- EMPLOYEE 테이블에서 
-- 부서코드가  'D5', 'D6', 'D9'인 아닌 사원의
-- 이름, 부서코드, 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE NOT IN ('D5', 'D6', 'D9');
    


/* 위 예제에서 제외된 2명 결과에 추가하는 SQL */
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE NOT IN ('D5', 'D6', 'D9')
OR DEPT_CODE IS NULL; -- 11    
    
    
    
----------------------------------------------------------------

/*  **** LIKE ****
 * 
 * - 비교하려는 값이 특정한 패턴을 만족 시키면(TRUE) 조회하는 연산자
 * 
 * [작성법]
 * WHERE 컬럼명 LIKE '패턴'
 * 
 * - LIKE 패턴( == 와일드 카드  ) 
 * 
 * '%' (포함)
 * - '%A' : 문자열이 앞은 어떤 문자든 포함되고 마지막은 A
 * 			-> A로 끝나는 문자열
 * - 'A%' : A로 시작하는 문자열
 * - '%A%' : A가 포함된 문자열
 *  
 * 
 * '_' (글자 수)
 * - 'A_' : A 뒤에 아무거나 한 글자만 있는 문자열
 *          (AB ,A1, AQ, A가)
 * 
 * - '___A' : A 앞에 아무거나 3글자만 있는 문자열
 */


-- EMPLOYEE 테이블에서 성이 '전' 씨인 사원의 사번, 이름 조회
SELECT EMP_ID, EMP_NAME
FROM EMPLOYEE
WHERE EMP_NAME LIKE '전%';



-- EMPLOYEE 테이블에서 이름이 '수' 로 끝나는 사원의 사번, 이름 조회

SELECT EMP_ID, EMP_NAME
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%수';




-- EMPLOYEE 테이블에서 이름에 '하' 가 포함되는 사원의 사번, 이름 조회

SELECT EMP_ID, EMP_NAME
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%하%';





-- EMPLOYEE 테이블에서 이름이 '전' 시작, '돈' 끝나는 사원의 사번, 이름 조회


SELECT EMP_ID, EMP_NAME
FROM EMPLOYEE
WHERE EMP_NAME LIKE '전%돈';

    
    
-- EMPLOYEE 테이블에서
-- 전화번호가 '010'으로 시작하는 사원의 이름, 전화번호 조회
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE PHONE LIKE '010________';
    


-- EMPLOYEE 테이블에서
-- EMAIL의 아이디 (@ 앞의 글자)의 글자 수가 5글자인 사원의
-- 이름, EMAIL 조회
SELECT EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '_____@%';
    
    
-- EMPLOYEE 테이블에서
-- 이메일의 아이디 중 '_' 앞 쪽 글자의 수가 3글자인 사원의
-- 사번, 이름, 이메일 조회
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '____%';
    
       
-- 문제점 : 
-- 기준으로 삼은 문자 '_'와 
-- LIKE의 와일드 카드 '_'의 표기법이 동일하여
-- 모든 '_'가 와이드 카드로 인식됨

 --> '____%' : 앞에 4글자 있고, 뒤에 아무거나
    --  == 4글자 이상


-- 해결 방법 : 
-- LIKE의 ESCAPE 옵션 사용하기


--> ESCAPE 옵션 : 와일드 카드의 의미를 벗어나 단순 문자열로 인식
-->   적용 범위 : 특수문자 뒤 한 글자


SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '___#_%' ESCAPE '#';


/* **** ORDER BY 절 ****
 * 
 * - SELECT문의 조회 결과(RESULT SET)를 정렬할 때 사용하는 구문
 * 
 * - *** SELECT구문에서 제일 마지막에 해석된다! ***
 * 
 * [작성법]
 * 3: SELECT 컬럼명 AS 별칭, 컬럼명, 컬럼명, ...
 * 1: FROM 테이블명
 * 2: WHERE 조건식
 * 4: ORDER BY 컬럼명 | 별칭 | 컬럼 순서 [오름/내림 차순] 
 * 	        [NULLS FIRST | LAST]
 * */



SELECT EMP_NAME, SALARY
FROM EMPLOYEE
ORDER BY SALARY ASC;  --ASC 오른차순 


-- EMPLOYEE 테이블에서
-- 모든 사원의 이름, 급여 조회
-- 단, 급여 내림차순으로 정렬
/*2*/SELECT EMP_NAME, SALARY
/*1*/FROM EMPLOYEE
/*3*/ORDER BY SALARY DESC;  -- DESC(descending) : 내림차순 


SELECT EMP_ID, EMP_NAME, DEPT_CODE 
FROM EMPLOYEE
WHERE DEPT_CODE IN('D5','D6','D9')
ORDER BY DEPT_CODE;   --ASC<생략가능



/* 컬럼 순서를 이용해 정렬하기 */

-- EMPLOYEE 테이블에서
-- 급여가 300만 이상, 600만 이하인 사원의
-- 사번, 이름, 급여를 이름 내림차순으로 조회

SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY BETWEEN 3000000 AND 60000000
ORDER BY 2 DESC;


/* ORDER BY절에 수식 적용 */
-- EMPLOYEE 테이블에서 이름, 연봉을 연봉 내림차순으로 조회
SELECT EMP_NAME, SALARY * 12
FROM EMPLOYEE
ORDER BY SALARY * 12 DESC;

-- ** 정렬 시 SELECT절에 작성된 컬럼을 
--    그대로 따라 적는 경우가 많다!

/* ORDER BY절에서 별칭 사용 하기*/
--> SELECT절 해석 이후 ORDER BY절이 해석되기 때문에
-- SELECT절에서 해석된 별칭을 ORDER BY절에서 사용할 수 있다

SELECT EMP_NAME, SALARY * 12 연봉
FROM EMPLOYEE
ORDER BY 연봉 DESC;



/* WHERE절 별칭 사용 불가 확인! */

-- EMPLOYEE 테이블에서
-- 모든 사원의 이름, 급여 조회
-- 단, 급여 오름차순으로 정렬
/*2*/SELECT EMP_NAME, SALARY
/*1*/FROM EMPLOYEE
/*3*/ORDER BY SALARY ASC;  -- ASC(ascending) : 오름차순




/* NULLS FIRST / LAST 옵션 적용하기 */

-- 모든 사원의 이름, 전화번호 조회

-- 오름차순 + NULLS FIRST (NULL인 경우 제일 위에)
SELECT EMP_NAME, PHONE FROM EMPLOYEE
ORDER BY PHONE NULLS FIRST; 

-- 오름차순 + NULLS LAST (NULL인 경우 제일 아래)
SELECT EMP_NAME, PHONE FROM EMPLOYEE
ORDER BY PHONE /*NULLS LAST*/; -- 기본 값


-- 내림차순 + NULLS FIRST (NULL인 경우 제일 위에)
SELECT EMP_NAME, PHONE FROM EMPLOYEE
ORDER BY PHONE DESC NULLS FIRST;  -- 정렬 기준 -> NULL 위치 순서대로 해석



/**** 정렬 중첩 ****/



-- EMPLOYEE 테이블에서
-- 이름, 부서코드, 급여를
-- 부서코드 오름차순, 급여 내림차순으로 조회


SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
ORDER BY DEPT_CODE;


-- EMPLOYEE 테이블에서
-- 이름, 부서코드, 직급코드(JOB_CODE)를
-- 부서코드 오름차순, 직급코드 내림 차순, 이름 오름차순으로 조회




SELECT EMP_NAME, DEPT_CODE, JOB_CODE
FROM EMPLOYEE 
ORDER BY DEPT_CODE, JOB_CODE, EMP_NAME DESC;


























    
    









