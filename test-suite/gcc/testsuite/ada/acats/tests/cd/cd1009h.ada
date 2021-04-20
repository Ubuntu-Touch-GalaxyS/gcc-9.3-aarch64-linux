-- CD1009H.ADA

--                             Grant of Unlimited Rights
--
--     Under contracts F33600-87-D-0337, F33600-84-D-0280, MDA903-79-C-0687,
--     F08630-91-C-0015, and DCA100-97-D-0025, the U.S. Government obtained 
--     unlimited rights in the software and documentation contained herein.
--     Unlimited rights are defined in DFAR 252.227-7013(a)(19).  By making 
--     this public release, the Government intends to confer upon all 
--     recipients unlimited rights  equal to those held by the Government.  
--     These rights include rights to use, duplicate, release or disclose the 
--     released technical data and computer software in whole or in part, in 
--     any manner and for any purpose whatsoever, and to have or permit others 
--     to do so.
--
--                                    DISCLAIMER
--
--     ALL MATERIALS OR INFORMATION HEREIN RELEASED, MADE AVAILABLE OR
--     DISCLOSED ARE AS IS.  THE GOVERNMENT MAKES NO EXPRESS OR IMPLIED 
--     WARRANTY AS TO ANY MATTER WHATSOEVER, INCLUDING THE CONDITIONS OF THE
--     SOFTWARE, DOCUMENTATION OR OTHER INFORMATION RELEASED, MADE AVAILABLE 
--     OR DISCLOSED, OR THE OWNERSHIP, MERCHANTABILITY, OR FITNESS FOR A
--     PARTICULAR PURPOSE OF SAID MATERIAL.
--*
-- OBJECTIVE:
--     CHECK THAT A 'SIZE' SPECIFICATION MAY BE GIVEN IN THE PRIVATE
--     PART OF A PACKAGE FOR A PRIVATE TYPE DECLARED IN THE VISIBLE
--     PART OF THE SAME PACKAGE.

-- HISTORY:
--     PWB 03/25/89  MODIFIED METHOD OF CHECKING OBJECT SIZE AGAINST
--                   TYPE SIZE; CHANGED EXTENSION FROM '.ADA' TO '.DEP'.
--     VCL  09/18/87  CREATED ORIGINAL TEST.

WITH REPORT; USE REPORT;
PROCEDURE CD1009H IS
BEGIN
     TEST ("CD1009H", "A 'SIZE' CLAUSE MAY BE GIVEN IN THE " &
                      "PRIVATE PART OF A PACKAGE FOR A PRIVATE " &
                      "TYPE DECLARED IN THE VISIBLE PART OF THE " &
                      "SAME PACKAGE");
     DECLARE
          PACKAGE PACK IS
               SPECIFIED_SIZE : CONSTANT := INTEGER'SIZE / 2;

               TYPE CHECK_TYPE_1 IS PRIVATE;
               C1 : CONSTANT CHECK_TYPE_1;
               FUNCTION IMAGE ( A : CHECK_TYPE_1 ) RETURN STRING;
          PRIVATE
               TYPE CHECK_TYPE_1 IS RANGE 0 .. 7;
               FOR CHECK_TYPE_1'SIZE
                              USE SPECIFIED_SIZE;
               C1 : CONSTANT CHECK_TYPE_1 := CHECK_TYPE_1(IDENT_INT(1));
          END PACK;

          USE PACK;
          X : CHECK_TYPE_1 := C1;

          PACKAGE BODY PACK IS
               FUNCTION IMAGE ( A : CHECK_TYPE_1 ) RETURN STRING IS
               BEGIN
                    RETURN INTEGER'IMAGE ( INTEGER (A) );
               END IMAGE;
         END PACK;

     BEGIN
          IF CHECK_TYPE_1'SIZE /= SPECIFIED_SIZE THEN
               FAILED ("CHECK_TYPE_1'SIZE IS INCORRECT");
          END IF;

          IF X'SIZE < SPECIFIED_SIZE THEN
               FAILED ("OBJECT SIZE TOO SMALL -- CHECK_TYPE_1.  " &
                       "VALUE IS"  & IMAGE(X));
          END IF;

     END;

     RESULT;
END CD1009H;
