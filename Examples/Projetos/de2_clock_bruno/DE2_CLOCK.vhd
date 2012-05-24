LIBRARY IEEE;
USE  IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_UNSIGNED.all;

ENTITY DE2_CLOCK IS
	PORT(reset, clk_50Mhz   		: IN STD_LOGIC;
		 sel                        : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
		 LCD_RS, LCD_E, LCD_ON      : OUT STD_LOGIC;
		 LCD_RW						: BUFFER STD_LOGIC;
		 DATA_BUS				    : INOUT	STD_LOGIC_VECTOR(7 DOWNTO 0));
END DE2_CLOCK;

ARCHITECTURE a OF DE2_CLOCK IS

	TYPE STATE_TYPE IS (HOLD, FUNC_SET, DISPLAY_ON, MODE_SET, WRITE_CHAR1, WRITE_CHAR2, WRITE_CHAR3, WRITE_CHAR4, 
	WRITE_CHAR5, WRITE_CHAR6, WRITE_CHAR7, WRITE_CHAR8, WRITE_CHAR9, WRITE_CHAR10, RETURN_HOME, TOGGLE_E, 
	RESET1, RESET2, RESET3, DISPLAY_OFF, DISPLAY_CLEAR);
	SIGNAL state, next_command: STATE_TYPE;
	SIGNAL DATA_BUS_VALUE: STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL CLK_COUNT_400HZ: STD_LOGIC_VECTOR(19 DOWNTO 0);
	SIGNAL CLK_COUNT_10HZ: STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL CLK_400HZ, CLK_10HZ : STD_LOGIC;
	
BEGIN
	LCD_ON <= '1';
	DATA_BUS <= DATA_BUS_VALUE WHEN LCD_RW = '0' ELSE "ZZZZZZZZ";

	PROCESS
	BEGIN
	 WAIT UNTIL CLK_50MHZ'EVENT AND CLK_50MHZ = '1';
		IF RESET = '0' THEN
		 CLK_COUNT_400HZ <= X"00000";
		 CLK_400HZ <= '0';
		ELSE
				IF CLK_COUNT_400HZ < X"0F424" THEN 
				 CLK_COUNT_400HZ <= CLK_COUNT_400HZ + 1;
				ELSE
		    	 CLK_COUNT_400HZ <= X"00000";
				 CLK_400HZ <= NOT CLK_400HZ;
				END IF;
		END IF;
	END PROCESS;
	
	PROCESS (CLK_400HZ, reset, sel)
	BEGIN
		IF reset = '0' THEN
			state <= RESET1;
			DATA_BUS_VALUE <= X"38";
			next_command <= RESET2;
			LCD_E <= '1';
			LCD_RS <= '0';
			LCD_RW <= '0';

		ELSIF CLK_400HZ'EVENT AND CLK_400HZ = '1' THEN
-- GENERATE 1/10 SEC CLOCK SIGNAL FOR SECOND COUNT PROCESS
			IF CLK_COUNT_10HZ < 19 THEN
				CLK_COUNT_10HZ <= CLK_COUNT_10HZ + 1;
			ELSE
				CLK_COUNT_10HZ <= X"00";
				CLK_10HZ <= NOT CLK_10HZ;
			END IF;

				CASE state IS
					WHEN RESET1 =>
							LCD_E <= '1';
							LCD_RS <= '0';
							LCD_RW <= '0';
							DATA_BUS_VALUE <= X"38";
							state <= TOGGLE_E;
							next_command <= RESET2;
					WHEN RESET2 =>
							LCD_E <= '1';
							LCD_RS <= '0';
							LCD_RW <= '0';
							DATA_BUS_VALUE <= X"38";
							state <= TOGGLE_E;
							next_command <= RESET3;

					WHEN RESET3 =>
							LCD_E <= '1';
							LCD_RS <= '0';
							LCD_RW <= '0';
							DATA_BUS_VALUE <= X"38";
							state <= TOGGLE_E;
							next_command <= FUNC_SET;

					WHEN FUNC_SET =>
							LCD_E <= '1';
							LCD_RS <= '0';
							LCD_RW <= '0';
							DATA_BUS_VALUE <= X"38";
							state <= TOGGLE_E;
							next_command <= DISPLAY_OFF;
							
					WHEN DISPLAY_OFF =>
							LCD_E <= '1';
							LCD_RS <= '0';
							LCD_RW <= '0';
							DATA_BUS_VALUE <= X"08";
							state <= TOGGLE_E;
							next_command <= DISPLAY_CLEAR;
							
					WHEN DISPLAY_CLEAR =>
							LCD_E <= '1';
							LCD_RS <= '0';
							LCD_RW <= '0';
							DATA_BUS_VALUE <= X"01";
							state <= TOGGLE_E;
							next_command <= DISPLAY_ON;
							
					WHEN DISPLAY_ON =>
							LCD_E <= '1';
							LCD_RS <= '0';
							LCD_RW <= '0';
							DATA_BUS_VALUE <= X"0C";
							state <= TOGGLE_E;
							next_command <= MODE_SET;
							
					WHEN MODE_SET =>
							LCD_E <= '1';
							LCD_RS <= '0';
							LCD_RW <= '0';
							DATA_BUS_VALUE <= X"06";
							state <= TOGGLE_E;
							next_command <= WRITE_CHAR1;
							
					WHEN WRITE_CHAR1 =>
							LCD_E <= '1';
							LCD_RS <= '1';
							LCD_RW <= '0';
							IF sel = "000000" THEN
								DATA_BUS_VALUE <= X"43"; -- [C]H 0 
							ELSIF sel = "000001" THEN
								DATA_BUS_VALUE <= X"43"; -- [C]H 1 
							ELSIF sel = "000010" THEN
								DATA_BUS_VALUE <= X"43"; -- [C]H 2 
							ELSIF sel = "000011" THEN
								DATA_BUS_VALUE <= X"43"; -- [C]H 3 
							ELSIF sel = "000100" THEN
								DATA_BUS_VALUE <= X"43"; -- [C]H 4 
							ELSIF sel = "000101" THEN
								DATA_BUS_VALUE <= X"43"; -- [C]H 5 
							ELSIF sel = "000110" THEN
								DATA_BUS_VALUE <= X"43"; -- [C]H 6 
							ELSIF sel = "000111" THEN
								DATA_BUS_VALUE <= X"43"; -- [C]H 7 
							ELSIF sel = "001000" THEN
								DATA_BUS_VALUE <= X"43"; -- [C]H 8
							ELSIF sel = "001001" THEN
								DATA_BUS_VALUE <= X"43"; -- [C]H 9 
							ELSIF sel = "001010" THEN
								DATA_BUS_VALUE <= X"50"; -- [P]OWER 
							ELSIF sel = "001011" THEN
								DATA_BUS_VALUE <= X"52"; -- [R]ADIO 
							ELSIF sel = "001100" THEN
								DATA_BUS_VALUE <= X"54"; -- [T]V 
							ELSIF sel = "001101" THEN
								DATA_BUS_VALUE <= X"4D"; -- [M]EDIA 
							ELSIF sel = "001110" THEN
								DATA_BUS_VALUE <= X"44"; -- [D]VD 
							ELSIF sel = "001111" THEN
								DATA_BUS_VALUE <= X"4D"; -- [M]USIC 
							ELSIF sel = "010000" THEN
								DATA_BUS_VALUE <= X"50"; -- [P]ICTURE 
							ELSIF sel = "010001" THEN
								DATA_BUS_VALUE <= X"56"; -- [V]IDEO 
							ELSIF sel = "010010" THEN
								DATA_BUS_VALUE <= X"44"; -- [D]VD/MENU 
							ELSIF sel = "010011" THEN
								DATA_BUS_VALUE <= X"55"; -- [U]P 
							ELSIF sel = "010100" THEN
								DATA_BUS_VALUE <= X"4D"; -- [M]UTE 
							ELSIF sel = "010101" THEN
								DATA_BUS_VALUE <= X"56"; -- [V]OL +
							ELSIF sel = "010110" THEN
								DATA_BUS_VALUE <= X"4C"; -- [L]EFT
							ELSIF sel = "010111" THEN
								DATA_BUS_VALUE <= X"4D"; -- [M]ENU/ENTER
							ELSIF sel = "011000" THEN
								DATA_BUS_VALUE <= X"52"; -- [R]IGHT
							ELSIF sel = "011001" THEN
								DATA_BUS_VALUE <= X"56"; -- [V]OL -
							ELSIF sel = "011010" THEN
								DATA_BUS_VALUE <= X"42"; -- [B]ACK
							ELSIF sel = "011011" THEN
								DATA_BUS_VALUE <= X"44"; -- [D]OWN
							ELSIF sel = "011100" THEN
								DATA_BUS_VALUE <= X"47"; -- [G]UIDE
							ELSIF sel = "011101" THEN
								DATA_BUS_VALUE <= X"43"; -- [C]H +
							ELSIF sel = "011110" THEN
								DATA_BUS_VALUE <= X"43"; -- [C]H -
							ELSIF sel = "011111" THEN
								DATA_BUS_VALUE <= X"52"; -- [R]EDPOINT
							ELSIF sel = "100000" THEN
								DATA_BUS_VALUE <= X"52"; -- [R]EPEAT
							ELSIF sel = "100001" THEN
								DATA_BUS_VALUE <= X"50"; -- [P]LAY
							ELSIF sel = "100010" THEN
								DATA_BUS_VALUE <= X"50"; -- [P]AUSE
							ELSIF sel = "100011" THEN
								DATA_BUS_VALUE <= X"53"; -- [S]TOP
							ELSIF sel = "100100" THEN
								DATA_BUS_VALUE <= X"3C"; -- [<]<
							ELSIF sel = "100101" THEN
								DATA_BUS_VALUE <= X"3E"; -- [>]>
							ELSIF sel = "100110" THEN
								DATA_BUS_VALUE <= X"7C"; -- [|]<<
							ELSIF sel = "100111" THEN
								DATA_BUS_VALUE <= X"3E"; -- [>]>|
							ELSE
								DATA_BUS_VALUE <= X"57"; -- [W]AIT
							END IF;
							state <= TOGGLE_E;
							next_command <= WRITE_CHAR2;
							
					WHEN WRITE_CHAR2 =>
							LCD_E <= '1';
							LCD_RS <= '1';
							LCD_RW <= '0';
							IF sel = "000000" THEN
								DATA_BUS_VALUE <= X"48"; -- C[H] 0 
							ELSIF sel = "000001" THEN
								DATA_BUS_VALUE <= X"48"; -- C[H] 1 
							ELSIF sel = "000010" THEN
								DATA_BUS_VALUE <= X"48"; -- C[H] 2 
							ELSIF sel = "000011" THEN
								DATA_BUS_VALUE <= X"48"; -- C[H] 3 
							ELSIF sel = "000100" THEN
								DATA_BUS_VALUE <= X"48"; -- C[H] 4 
							ELSIF sel = "000101" THEN
								DATA_BUS_VALUE <= X"48"; -- C[H] 5 
							ELSIF sel = "000110" THEN
								DATA_BUS_VALUE <= X"48"; -- C[H] 6 
							ELSIF sel = "000111" THEN
								DATA_BUS_VALUE <= X"48"; -- C[H] 7 
							ELSIF sel = "001000" THEN
								DATA_BUS_VALUE <= X"48"; -- C[H] 8
							ELSIF sel = "001001" THEN
								DATA_BUS_VALUE <= X"48"; -- C[H] 9 
							ELSIF sel = "001010" THEN
								DATA_BUS_VALUE <= X"4F"; -- P[O]WER 
							ELSIF sel = "001011" THEN
								DATA_BUS_VALUE <= X"41"; -- R[A]DIO 
							ELSIF sel = "001100" THEN
								DATA_BUS_VALUE <= X"56"; -- T[V] 
							ELSIF sel = "001101" THEN
								DATA_BUS_VALUE <= X"45"; -- M[E]DIA 
							ELSIF sel = "001110" THEN
								DATA_BUS_VALUE <= X"56"; -- D[V]D 
							ELSIF sel = "001111" THEN
								DATA_BUS_VALUE <= X"55"; -- M[U]SIC 
							ELSIF sel = "010000" THEN
								DATA_BUS_VALUE <= X"49"; -- P[I]CTURE 
							ELSIF sel = "010001" THEN
								DATA_BUS_VALUE <= X"49"; -- V[I]DEO 
							ELSIF sel = "010010" THEN
								DATA_BUS_VALUE <= X"56"; -- D[V]D/MENU 
							ELSIF sel = "010011" THEN
								DATA_BUS_VALUE <= X"50"; -- U[P]
							ELSIF sel = "010100" THEN
								DATA_BUS_VALUE <= X"55"; -- M[U]TE 
							ELSIF sel = "010101" THEN
								DATA_BUS_VALUE <= X"4F"; -- V[O]L +
							ELSIF sel = "010110" THEN
								DATA_BUS_VALUE <= X"45"; -- L[E]FT
							ELSIF sel = "010111" THEN
								DATA_BUS_VALUE <= X"45"; -- M[E]NU/ENTER
							ELSIF sel = "011000" THEN
								DATA_BUS_VALUE <= X"49"; -- R[I]GHT
							ELSIF sel = "011001" THEN
								DATA_BUS_VALUE <= X"4F"; -- V[O]L -
							ELSIF sel = "011010" THEN
								DATA_BUS_VALUE <= X"41"; -- B[A]CK
							ELSIF sel = "011011" THEN
								DATA_BUS_VALUE <= X"4F"; -- D[O]WN
							ELSIF sel = "011100" THEN
								DATA_BUS_VALUE <= X"55"; -- G[U]IDE
							ELSIF sel = "011101" THEN
								DATA_BUS_VALUE <= X"48"; -- C[H] +
							ELSIF sel = "011110" THEN
								DATA_BUS_VALUE <= X"48"; -- C[H] -
							ELSIF sel = "011111" THEN
								DATA_BUS_VALUE <= X"45"; -- R[E]DPOINT
							ELSIF sel = "100000" THEN
								DATA_BUS_VALUE <= X"45"; -- R[E]PEAT
							ELSIF sel = "100001" THEN
								DATA_BUS_VALUE <= X"4C"; -- P[L]AY
							ELSIF sel = "100010" THEN
								DATA_BUS_VALUE <= X"41"; -- P[A]USE
							ELSIF sel = "100011" THEN
								DATA_BUS_VALUE <= X"54"; -- S[T]OP
							ELSIF sel = "100100" THEN
								DATA_BUS_VALUE <= X"3C"; -- <[<]
							ELSIF sel = "100101" THEN
								DATA_BUS_VALUE <= X"3E"; -- >[>]
							ELSIF sel = "100110" THEN
								DATA_BUS_VALUE <= X"3C"; -- |[<]<
							ELSIF sel = "100111" THEN
								DATA_BUS_VALUE <= X"3E"; -- >[>]|
							ELSE
								DATA_BUS_VALUE <= X"41"; -- W[A]IT
							END IF;
							state <= TOGGLE_E;
							next_command <= WRITE_CHAR3;
							
					WHEN WRITE_CHAR3 =>
							LCD_E <= '1';
							LCD_RS <= '1';
							LCD_RW <= '0';
							IF sel = "000000" THEN
								DATA_BUS_VALUE <= X"11"; -- CH[ ]0 
							ELSIF sel = "000001" THEN
								DATA_BUS_VALUE <= X"11"; -- CH[ ]1 
							ELSIF sel = "000010" THEN
								DATA_BUS_VALUE <= X"11"; -- CH[ ]2 
							ELSIF sel = "000011" THEN
								DATA_BUS_VALUE <= X"11"; -- CH[ ]3 
							ELSIF sel = "000100" THEN
								DATA_BUS_VALUE <= X"11"; -- CH[ ]4 
							ELSIF sel = "000101" THEN
								DATA_BUS_VALUE <= X"11"; -- CH[ ]5 
							ELSIF sel = "000110" THEN
								DATA_BUS_VALUE <= X"11"; -- CH[ ]6 
							ELSIF sel = "000111" THEN
								DATA_BUS_VALUE <= X"11"; -- CH[ ]7 
							ELSIF sel = "001000" THEN
								DATA_BUS_VALUE <= X"11"; -- CH[ ]8
							ELSIF sel = "001001" THEN
								DATA_BUS_VALUE <= X"11"; -- CH[ ]9 
							ELSIF sel = "001010" THEN
								DATA_BUS_VALUE <= X"57"; -- PO[W]ER 
							ELSIF sel = "001011" THEN
								DATA_BUS_VALUE <= X"44"; -- RA[D]IO 
							ELSIF sel = "001100" THEN
								DATA_BUS_VALUE <= X"11"; -- TV[ ]
							ELSIF sel = "001101" THEN
								DATA_BUS_VALUE <= X"44"; -- ME[D]IA 
							ELSIF sel = "001110" THEN
								DATA_BUS_VALUE <= X"44"; -- DV[D] 
							ELSIF sel = "001111" THEN
								DATA_BUS_VALUE <= X"53"; -- MU[S]IC 
							ELSIF sel = "010000" THEN
								DATA_BUS_VALUE <= X"43"; -- PI[C]TURE 
							ELSIF sel = "010001" THEN
								DATA_BUS_VALUE <= X"44"; -- VI[D]EO 
							ELSIF sel = "010010" THEN
								DATA_BUS_VALUE <= X"44"; -- DV[D]/MENU 
							ELSIF sel = "010011" THEN
								DATA_BUS_VALUE <= X"11"; -- UP[ ]
							ELSIF sel = "010100" THEN
								DATA_BUS_VALUE <= X"54"; -- MU[T]E 
							ELSIF sel = "010101" THEN
								DATA_BUS_VALUE <= X"4C"; -- VO[L] +
							ELSIF sel = "010110" THEN
								DATA_BUS_VALUE <= X"46"; -- LE[F]T
							ELSIF sel = "010111" THEN
								DATA_BUS_VALUE <= X"4E"; -- ME[N]U/ENTER
							ELSIF sel = "011000" THEN
								DATA_BUS_VALUE <= X"47"; -- RI[G]HT
							ELSIF sel = "011001" THEN
								DATA_BUS_VALUE <= X"4C"; -- VO[L] -
							ELSIF sel = "011010" THEN
								DATA_BUS_VALUE <= X"43"; -- BA[C]K
							ELSIF sel = "011011" THEN
								DATA_BUS_VALUE <= X"57"; -- DO[W]N
							ELSIF sel = "011100" THEN
								DATA_BUS_VALUE <= X"49"; -- GU[I]DE
							ELSIF sel = "011101" THEN
								DATA_BUS_VALUE <= X"11"; -- CH[ ]+
							ELSIF sel = "011110" THEN
								DATA_BUS_VALUE <= X"11"; -- CH[ ]-
							ELSIF sel = "011111" THEN
								DATA_BUS_VALUE <= X"44"; -- RE[D]POINT
							ELSIF sel = "100000" THEN
								DATA_BUS_VALUE <= X"50"; -- RE[P]EAT
							ELSIF sel = "100001" THEN
								DATA_BUS_VALUE <= X"41"; -- PL[A]Y
							ELSIF sel = "100010" THEN
								DATA_BUS_VALUE <= X"55"; -- PA[U]SE
							ELSIF sel = "100011" THEN
								DATA_BUS_VALUE <= X"4F"; -- ST[O]P
							ELSIF sel = "100100" THEN
								DATA_BUS_VALUE <= X"11"; -- <<[ ]
							ELSIF sel = "100101" THEN
								DATA_BUS_VALUE <= X"11"; -- >>[ ]
							ELSIF sel = "100110" THEN
								DATA_BUS_VALUE <= X"3C"; -- |<[<]
							ELSIF sel = "100111" THEN
								DATA_BUS_VALUE <= X"7C"; -- >>[|]
							ELSE
								DATA_BUS_VALUE <= X"49"; -- WA[I]T
							END IF;
							state <= TOGGLE_E;
							next_command <= WRITE_CHAR4;
					
					WHEN WRITE_CHAR4 =>
							LCD_E <= '1';
							LCD_RS <= '1';
							LCD_RW <= '0';
							IF sel = "000000" THEN
								DATA_BUS_VALUE <= X"30"; -- CH [0] 
							ELSIF sel = "000001" THEN
								DATA_BUS_VALUE <= X"31"; -- CH [1] 
							ELSIF sel = "000010" THEN
								DATA_BUS_VALUE <= X"32"; -- CH [2] 
							ELSIF sel = "000011" THEN
								DATA_BUS_VALUE <= X"33"; -- CH [3]
							ELSIF sel = "000100" THEN
								DATA_BUS_VALUE <= X"34"; -- CH [4]
							ELSIF sel = "000101" THEN
								DATA_BUS_VALUE <= X"35"; -- CH [5]
							ELSIF sel = "000110" THEN
								DATA_BUS_VALUE <= X"36"; -- CH [6]
							ELSIF sel = "000111" THEN
								DATA_BUS_VALUE <= X"37"; -- CH [7]
							ELSIF sel = "001000" THEN
								DATA_BUS_VALUE <= X"38"; -- CH [8]
							ELSIF sel = "001001" THEN
								DATA_BUS_VALUE <= X"39"; -- CH [9]
							ELSIF sel = "001010" THEN
								DATA_BUS_VALUE <= X"45"; -- POW[E]R 
							ELSIF sel = "001011" THEN
								DATA_BUS_VALUE <= X"49"; -- RAD[I]O 
							ELSIF sel = "001100" THEN
								DATA_BUS_VALUE <= X"11"; -- TV[ ]
							ELSIF sel = "001101" THEN
								DATA_BUS_VALUE <= X"49"; -- MED[I]A 
							ELSIF sel = "001110" THEN
								DATA_BUS_VALUE <= X"11"; -- DVD[ ]
							ELSIF sel = "001111" THEN
								DATA_BUS_VALUE <= X"49"; -- MUS[I]C 
							ELSIF sel = "010000" THEN
								DATA_BUS_VALUE <= X"54"; -- PIC[T]URE 
							ELSIF sel = "010001" THEN
								DATA_BUS_VALUE <= X"45"; -- VID[E]O 
							ELSIF sel = "010010" THEN
								DATA_BUS_VALUE <= X"2F"; -- DVD[/]MENU 
							ELSIF sel = "010011" THEN
								DATA_BUS_VALUE <= X"11"; -- UP[ ]
							ELSIF sel = "010100" THEN
								DATA_BUS_VALUE <= X"45"; -- MUT[E] 
							ELSIF sel = "010101" THEN
								DATA_BUS_VALUE <= X"11"; -- VOL[ ]+
							ELSIF sel = "010110" THEN
								DATA_BUS_VALUE <= X"54"; -- LEF[T]
							ELSIF sel = "010111" THEN
								DATA_BUS_VALUE <= X"55"; -- MEN[U]/ENTER
							ELSIF sel = "011000" THEN
								DATA_BUS_VALUE <= X"48"; -- RIG[H]T
							ELSIF sel = "011001" THEN
								DATA_BUS_VALUE <= X"11"; -- VOL[ ]-
							ELSIF sel = "011010" THEN
								DATA_BUS_VALUE <= X"4B"; -- BAC[K]
							ELSIF sel = "011011" THEN
								DATA_BUS_VALUE <= X"4E"; -- DOW[N]
							ELSIF sel = "011100" THEN
								DATA_BUS_VALUE <= X"44"; -- GUI[D]E
							ELSIF sel = "011101" THEN
								DATA_BUS_VALUE <= X"2B"; -- CH [+]
							ELSIF sel = "011110" THEN
								DATA_BUS_VALUE <= X"2D"; -- CH [-]
							ELSIF sel = "011111" THEN
								DATA_BUS_VALUE <= X"50"; -- RED[P]OINT
							ELSIF sel = "100000" THEN
								DATA_BUS_VALUE <= X"45"; -- REP[E]AT
							ELSIF sel = "100001" THEN
								DATA_BUS_VALUE <= X"59"; -- PLA[Y]
							ELSIF sel = "100010" THEN
								DATA_BUS_VALUE <= X"53"; -- PAU[S]E
							ELSIF sel = "100011" THEN
								DATA_BUS_VALUE <= X"50"; -- STO[P]
							ELSIF sel = "100100" THEN
								DATA_BUS_VALUE <= X"11"; -- <<[ ]
							ELSIF sel = "100101" THEN
								DATA_BUS_VALUE <= X"11"; -- >>[ ]
							ELSIF sel = "100110" THEN
								DATA_BUS_VALUE <= X"11"; -- |<<[ ]
							ELSIF sel = "100111" THEN
								DATA_BUS_VALUE <= X"11"; -- >>| [ ]
							ELSE
								DATA_BUS_VALUE <= X"54"; -- WAI[T]
							END IF;
							state <= TOGGLE_E;
							next_command <= WRITE_CHAR5;		
					
					WHEN WRITE_CHAR5 =>
							LCD_E <= '1';
							LCD_RS <= '1';
							LCD_RW <= '0';
							IF sel = "000000" THEN
								DATA_BUS_VALUE <= X"11"; -- CH 0[ ] 
							ELSIF sel = "000001" THEN
								DATA_BUS_VALUE <= X"11"; -- CH 1[ ]
							ELSIF sel = "000010" THEN
								DATA_BUS_VALUE <= X"11"; -- CH 2[ ]
							ELSIF sel = "000011" THEN
								DATA_BUS_VALUE <= X"11"; -- CH 3[ ]
							ELSIF sel = "000100" THEN
								DATA_BUS_VALUE <= X"11"; -- CH 4[ ]
							ELSIF sel = "000101" THEN
								DATA_BUS_VALUE <= X"11"; -- CH 5[ ]
							ELSIF sel = "000110" THEN
								DATA_BUS_VALUE <= X"11"; -- CH 6[ ]
							ELSIF sel = "000111" THEN
								DATA_BUS_VALUE <= X"11"; -- CH 7[ ]
							ELSIF sel = "001000" THEN
								DATA_BUS_VALUE <= X"11"; -- CH 8[ ]
							ELSIF sel = "001001" THEN
								DATA_BUS_VALUE <= X"11"; -- CH 9[ ]
							ELSIF sel = "001010" THEN
								DATA_BUS_VALUE <= X"52"; -- POWE[R] 
							ELSIF sel = "001011" THEN
								DATA_BUS_VALUE <= X"4F"; -- RADI[O] 
							ELSIF sel = "001100" THEN
								DATA_BUS_VALUE <= X"11"; -- TV[ ]
							ELSIF sel = "001101" THEN
								DATA_BUS_VALUE <= X"41"; -- MEDI[A] 
							ELSIF sel = "001110" THEN
								DATA_BUS_VALUE <= X"11"; -- DVD[ ]
							ELSIF sel = "001111" THEN
								DATA_BUS_VALUE <= X"43"; -- MUSI[C] 
							ELSIF sel = "010000" THEN
								DATA_BUS_VALUE <= X"55"; -- PICT[U]RE 
							ELSIF sel = "010001" THEN
								DATA_BUS_VALUE <= X"4F"; -- VIDE[O] 
							ELSIF sel = "010010" THEN
								DATA_BUS_VALUE <= X"4D"; -- DVD/[M]ENU 
							ELSIF sel = "010011" THEN
								DATA_BUS_VALUE <= X"11"; -- UP[ ]
							ELSIF sel = "010100" THEN
								DATA_BUS_VALUE <= X"11"; -- MUTE[ ]
							ELSIF sel = "010101" THEN
								DATA_BUS_VALUE <= X"2B"; -- VOL [+]
							ELSIF sel = "010110" THEN
								DATA_BUS_VALUE <= X"11"; -- LEFT[ ]
							ELSIF sel = "010111" THEN
								DATA_BUS_VALUE <= X"2F"; -- MENU[/]ENTER
							ELSIF sel = "011000" THEN
								DATA_BUS_VALUE <= X"54"; -- RIGH[T]
							ELSIF sel = "011001" THEN
								DATA_BUS_VALUE <= X"2D"; -- VOL [-]
							ELSIF sel = "011010" THEN
								DATA_BUS_VALUE <= X"11"; -- BACK[ ]
							ELSIF sel = "011011" THEN
								DATA_BUS_VALUE <= X"11"; -- DOWN[ ]
							ELSIF sel = "011100" THEN
								DATA_BUS_VALUE <= X"45"; -- GUID[E]
							ELSIF sel = "011101" THEN
								DATA_BUS_VALUE <= X"11"; -- CH +[ ]
							ELSIF sel = "011110" THEN
								DATA_BUS_VALUE <= X"11"; -- CH -[ ]
							ELSIF sel = "011111" THEN
								DATA_BUS_VALUE <= X"4F"; -- REDP[O]INT
							ELSIF sel = "100000" THEN
								DATA_BUS_VALUE <= X"41"; -- REPE[A]T
							ELSIF sel = "100001" THEN
								DATA_BUS_VALUE <= X"11"; -- PLAY[ ]
							ELSIF sel = "100010" THEN
								DATA_BUS_VALUE <= X"45"; -- PAUS[E]
							ELSIF sel = "100011" THEN
								DATA_BUS_VALUE <= X"11"; -- STOP[ ]
							ELSIF sel = "100100" THEN
								DATA_BUS_VALUE <= X"11"; -- <<[ ]
							ELSIF sel = "100101" THEN
								DATA_BUS_VALUE <= X"11"; -- >>[ ]
							ELSIF sel = "100110" THEN
								DATA_BUS_VALUE <= X"11"; -- |<<[ ]
							ELSIF sel = "100111" THEN
								DATA_BUS_VALUE <= X"11"; -- >>| [ ]
							ELSE
								DATA_BUS_VALUE <= X"11"; -- WAIT[ ]
							END IF;
							state <= TOGGLE_E;
							next_command <= WRITE_CHAR6;	
							
					WHEN WRITE_CHAR6 =>
							LCD_E <= '1';
							LCD_RS <= '1';
							LCD_RW <= '0';
							IF sel = "000000" THEN
								DATA_BUS_VALUE <= X"11"; -- CH 0[ ] 
							ELSIF sel = "000001" THEN
								DATA_BUS_VALUE <= X"11"; -- CH 1[ ]
							ELSIF sel = "000010" THEN
								DATA_BUS_VALUE <= X"11"; -- CH 2[ ]
							ELSIF sel = "000011" THEN
								DATA_BUS_VALUE <= X"11"; -- CH 3[ ]
							ELSIF sel = "000100" THEN
								DATA_BUS_VALUE <= X"11"; -- CH 4[ ]
							ELSIF sel = "000101" THEN
								DATA_BUS_VALUE <= X"11"; -- CH 5[ ]
							ELSIF sel = "000110" THEN
								DATA_BUS_VALUE <= X"11"; -- CH 6[ ]
							ELSIF sel = "000111" THEN
								DATA_BUS_VALUE <= X"11"; -- CH 7[ ]
							ELSIF sel = "001000" THEN
								DATA_BUS_VALUE <= X"11"; -- CH 8[ ]
							ELSIF sel = "001001" THEN
								DATA_BUS_VALUE <= X"11"; -- CH 9[ ]
							ELSIF sel = "001010" THEN
								DATA_BUS_VALUE <= X"11"; -- POWER[ ] 
							ELSIF sel = "001011" THEN
								DATA_BUS_VALUE <= X"11"; -- RADIO[ ]
							ELSIF sel = "001100" THEN
								DATA_BUS_VALUE <= X"11"; -- TV[ ]
							ELSIF sel = "001101" THEN
								DATA_BUS_VALUE <= X"11"; -- MEDIA[ ] 
							ELSIF sel = "001110" THEN
								DATA_BUS_VALUE <= X"11"; -- DVD[ ]
							ELSIF sel = "001111" THEN
								DATA_BUS_VALUE <= X"11"; -- MUSIC[ ]
							ELSIF sel = "010000" THEN
								DATA_BUS_VALUE <= X"52"; -- PICTU[R]E 
							ELSIF sel = "010001" THEN
								DATA_BUS_VALUE <= X"11"; -- VIDEO[ ] 
							ELSIF sel = "010010" THEN
								DATA_BUS_VALUE <= X"45"; -- DVD/M[E]NU 
							ELSIF sel = "010011" THEN
								DATA_BUS_VALUE <= X"11"; -- UP[ ]
							ELSIF sel = "010100" THEN
								DATA_BUS_VALUE <= X"11"; -- MUTE[ ]
							ELSIF sel = "010101" THEN
								DATA_BUS_VALUE <= X"11"; -- VOL +[ ]
							ELSIF sel = "010110" THEN
								DATA_BUS_VALUE <= X"11"; -- LEFT[ ]
							ELSIF sel = "010111" THEN
								DATA_BUS_VALUE <= X"45"; -- MENU/[E]NTER
							ELSIF sel = "011000" THEN
								DATA_BUS_VALUE <= X"11"; -- RIGHT[ ]
							ELSIF sel = "011001" THEN
								DATA_BUS_VALUE <= X"11"; -- VOL -[ ]
							ELSIF sel = "011010" THEN
								DATA_BUS_VALUE <= X"11"; -- BACK[ ]
							ELSIF sel = "011011" THEN
								DATA_BUS_VALUE <= X"11"; -- DOWN[ ]
							ELSIF sel = "011100" THEN
								DATA_BUS_VALUE <= X"11"; -- GUIDE[ ]
							ELSIF sel = "011101" THEN
								DATA_BUS_VALUE <= X"11"; -- CH +[ ]
							ELSIF sel = "011110" THEN
								DATA_BUS_VALUE <= X"11"; -- CH -[ ]
							ELSIF sel = "011111" THEN
								DATA_BUS_VALUE <= X"49"; -- REDPO[I]NT
							ELSIF sel = "100000" THEN
								DATA_BUS_VALUE <= X"54"; -- REPEA[T]
							ELSIF sel = "100001" THEN
								DATA_BUS_VALUE <= X"11"; -- PLAY[ ]
							ELSIF sel = "100010" THEN
								DATA_BUS_VALUE <= X"11"; -- PAUSE[ ]
							ELSIF sel = "100011" THEN
								DATA_BUS_VALUE <= X"11"; -- STOP[ ]
							ELSIF sel = "100100" THEN
								DATA_BUS_VALUE <= X"11"; -- <<[ ]
							ELSIF sel = "100101" THEN
								DATA_BUS_VALUE <= X"11"; -- >>[ ]
							ELSIF sel = "100110" THEN
								DATA_BUS_VALUE <= X"11"; -- |<<[ ]
							ELSIF sel = "100111" THEN
								DATA_BUS_VALUE <= X"11"; -- >>| [ ]
							ELSE
								DATA_BUS_VALUE <= X"11"; -- WAIT[ ]
							END IF;
							state <= TOGGLE_E;
							next_command <= WRITE_CHAR7;	
							
					WHEN WRITE_CHAR7 =>
							LCD_E <= '1';
							LCD_RS <= '1';
							LCD_RW <= '0';
							IF sel = "000000" THEN
								DATA_BUS_VALUE <= X"11"; -- CH 0[ ] 
							ELSIF sel = "000001" THEN
								DATA_BUS_VALUE <= X"11"; -- CH 1[ ]
							ELSIF sel = "000010" THEN
								DATA_BUS_VALUE <= X"11"; -- CH 2[ ]
							ELSIF sel = "000011" THEN
								DATA_BUS_VALUE <= X"11"; -- CH 3[ ]
							ELSIF sel = "000100" THEN
								DATA_BUS_VALUE <= X"11"; -- CH 4[ ]
							ELSIF sel = "000101" THEN
								DATA_BUS_VALUE <= X"11"; -- CH 5[ ]
							ELSIF sel = "000110" THEN
								DATA_BUS_VALUE <= X"11"; -- CH 6[ ]
							ELSIF sel = "000111" THEN
								DATA_BUS_VALUE <= X"11"; -- CH 7[ ]
							ELSIF sel = "001000" THEN
								DATA_BUS_VALUE <= X"11"; -- CH 8[ ]
							ELSIF sel = "001001" THEN
								DATA_BUS_VALUE <= X"11"; -- CH 9[ ]
							ELSIF sel = "001010" THEN
								DATA_BUS_VALUE <= X"11"; -- POWER[ ] 
							ELSIF sel = "001011" THEN
								DATA_BUS_VALUE <= X"11"; -- RADIO[ ]
							ELSIF sel = "001100" THEN
								DATA_BUS_VALUE <= X"11"; -- TV[ ]
							ELSIF sel = "001101" THEN
								DATA_BUS_VALUE <= X"11"; -- MEDIA[ ] 
							ELSIF sel = "001110" THEN
								DATA_BUS_VALUE <= X"11"; -- DVD[ ]
							ELSIF sel = "001111" THEN
								DATA_BUS_VALUE <= X"11"; -- MUSIC[ ]
							ELSIF sel = "010000" THEN
								DATA_BUS_VALUE <= X"45"; -- PICTUR[E] 
							ELSIF sel = "010001" THEN
								DATA_BUS_VALUE <= X"11"; -- VIDEO[ ] 
							ELSIF sel = "010010" THEN
								DATA_BUS_VALUE <= X"4E"; -- DVD/ME[N]U 
							ELSIF sel = "010011" THEN
								DATA_BUS_VALUE <= X"11"; -- UP[ ]
							ELSIF sel = "010100" THEN
								DATA_BUS_VALUE <= X"11"; -- MUTE[ ]
							ELSIF sel = "010101" THEN
								DATA_BUS_VALUE <= X"11"; -- VOL +[ ]
							ELSIF sel = "010110" THEN
								DATA_BUS_VALUE <= X"11"; -- LEFT[ ]
							ELSIF sel = "010111" THEN
								DATA_BUS_VALUE <= X"4E"; -- MENU/E[N]TER
							ELSIF sel = "011000" THEN
								DATA_BUS_VALUE <= X"11"; -- RIGHT[ ]
							ELSIF sel = "011001" THEN
								DATA_BUS_VALUE <= X"11"; -- VOL -[ ]
							ELSIF sel = "011010" THEN
								DATA_BUS_VALUE <= X"11"; -- BACK[ ]
							ELSIF sel = "011011" THEN
								DATA_BUS_VALUE <= X"11"; -- DOWN[ ]
							ELSIF sel = "011100" THEN
								DATA_BUS_VALUE <= X"11"; -- GUIDE[ ]
							ELSIF sel = "011101" THEN
								DATA_BUS_VALUE <= X"11"; -- CH +[ ]
							ELSIF sel = "011110" THEN
								DATA_BUS_VALUE <= X"11"; -- CH -[ ]
							ELSIF sel = "011111" THEN
								DATA_BUS_VALUE <= X"4E"; -- REDPOI[N]T
							ELSIF sel = "100000" THEN
								DATA_BUS_VALUE <= X"11"; -- REPEAT[ ]
							ELSIF sel = "100001" THEN
								DATA_BUS_VALUE <= X"11"; -- PLAY[ ]
							ELSIF sel = "100010" THEN
								DATA_BUS_VALUE <= X"11"; -- PAUSE[ ]
							ELSIF sel = "100011" THEN
								DATA_BUS_VALUE <= X"11"; -- STOP[ ]
							ELSIF sel = "100100" THEN
								DATA_BUS_VALUE <= X"11"; -- <<[ ]
							ELSIF sel = "100101" THEN
								DATA_BUS_VALUE <= X"11"; -- >>[ ]
							ELSIF sel = "100110" THEN
								DATA_BUS_VALUE <= X"11"; -- |<<[ ]
							ELSIF sel = "100111" THEN
								DATA_BUS_VALUE <= X"11"; -- >>| [ ]
							ELSE
								DATA_BUS_VALUE <= X"11"; -- WAIT[ ]
							END IF;
							state <= TOGGLE_E;
							next_command <= WRITE_CHAR8;	
							
					WHEN WRITE_CHAR8 =>
							LCD_E <= '1';
							LCD_RS <= '1';
							LCD_RW <= '0';
							IF sel = "000000" THEN
								DATA_BUS_VALUE <= X"11"; -- CH 0[ ] 
							ELSIF sel = "000001" THEN
								DATA_BUS_VALUE <= X"11"; -- CH 1[ ]
							ELSIF sel = "000010" THEN
								DATA_BUS_VALUE <= X"11"; -- CH 2[ ]
							ELSIF sel = "000011" THEN
								DATA_BUS_VALUE <= X"11"; -- CH 3[ ]
							ELSIF sel = "000100" THEN
								DATA_BUS_VALUE <= X"11"; -- CH 4[ ]
							ELSIF sel = "000101" THEN
								DATA_BUS_VALUE <= X"11"; -- CH 5[ ]
							ELSIF sel = "000110" THEN
								DATA_BUS_VALUE <= X"11"; -- CH 6[ ]
							ELSIF sel = "000111" THEN
								DATA_BUS_VALUE <= X"11"; -- CH 7[ ]
							ELSIF sel = "001000" THEN
								DATA_BUS_VALUE <= X"11"; -- CH 8[ ]
							ELSIF sel = "001001" THEN
								DATA_BUS_VALUE <= X"11"; -- CH 9[ ]
							ELSIF sel = "001010" THEN
								DATA_BUS_VALUE <= X"11"; -- POWER[ ] 
							ELSIF sel = "001011" THEN
								DATA_BUS_VALUE <= X"11"; -- RADIO[ ]
							ELSIF sel = "001100" THEN
								DATA_BUS_VALUE <= X"11"; -- TV[ ]
							ELSIF sel = "001101" THEN
								DATA_BUS_VALUE <= X"11"; -- MEDIA[ ] 
							ELSIF sel = "001110" THEN
								DATA_BUS_VALUE <= X"11"; -- DVD[ ]
							ELSIF sel = "001111" THEN
								DATA_BUS_VALUE <= X"11"; -- MUSIC[ ]
							ELSIF sel = "010000" THEN
								DATA_BUS_VALUE <= X"11"; -- PICTURE[ ]
							ELSIF sel = "010001" THEN
								DATA_BUS_VALUE <= X"11"; -- VIDEO[ ] 
							ELSIF sel = "010010" THEN
								DATA_BUS_VALUE <= X"55"; -- DVD/MEN[U] 
							ELSIF sel = "010011" THEN
								DATA_BUS_VALUE <= X"11"; -- UP[ ]
							ELSIF sel = "010100" THEN
								DATA_BUS_VALUE <= X"11"; -- MUTE[ ]
							ELSIF sel = "010101" THEN
								DATA_BUS_VALUE <= X"11"; -- VOL +[ ]
							ELSIF sel = "010110" THEN
								DATA_BUS_VALUE <= X"11"; -- LEFT[ ]
							ELSIF sel = "010111" THEN
								DATA_BUS_VALUE <= X"54"; -- MENU/EN[T]ER
							ELSIF sel = "011000" THEN
								DATA_BUS_VALUE <= X"11"; -- RIGHT[ ]
							ELSIF sel = "011001" THEN
								DATA_BUS_VALUE <= X"11"; -- VOL -[ ]
							ELSIF sel = "011010" THEN
								DATA_BUS_VALUE <= X"11"; -- BACK[ ]
							ELSIF sel = "011011" THEN
								DATA_BUS_VALUE <= X"11"; -- DOWN[ ]
							ELSIF sel = "011100" THEN
								DATA_BUS_VALUE <= X"11"; -- GUIDE[ ]
							ELSIF sel = "011101" THEN
								DATA_BUS_VALUE <= X"11"; -- CH +[ ]
							ELSIF sel = "011110" THEN
								DATA_BUS_VALUE <= X"11"; -- CH -[ ]
							ELSIF sel = "011111" THEN
								DATA_BUS_VALUE <= X"54"; -- REDPOIN[T]
							ELSIF sel = "100000" THEN
								DATA_BUS_VALUE <= X"11"; -- REPEAT[ ]
							ELSIF sel = "100001" THEN
								DATA_BUS_VALUE <= X"11"; -- PLAY[ ]
							ELSIF sel = "100010" THEN
								DATA_BUS_VALUE <= X"11"; -- PAUSE[ ]
							ELSIF sel = "100011" THEN
								DATA_BUS_VALUE <= X"11"; -- STOP[ ]
							ELSIF sel = "100100" THEN
								DATA_BUS_VALUE <= X"11"; -- <<[ ]
							ELSIF sel = "100101" THEN
								DATA_BUS_VALUE <= X"11"; -- >>[ ]
							ELSIF sel = "100110" THEN
								DATA_BUS_VALUE <= X"11"; -- |<<[ ]
							ELSIF sel = "100111" THEN
								DATA_BUS_VALUE <= X"11"; -- >>| [ ]
							ELSE
								DATA_BUS_VALUE <= X"11"; -- WAIT[ ]
							END IF;
							state <= TOGGLE_E;
							next_command <= WRITE_CHAR9;	
					
					WHEN WRITE_CHAR9 =>
							LCD_E <= '1';
							LCD_RS <= '1';
							LCD_RW <= '0';
							IF sel = "000000" THEN
								DATA_BUS_VALUE <= X"11"; -- CH 0[ ] 
							ELSIF sel = "000001" THEN
								DATA_BUS_VALUE <= X"11"; -- CH 1[ ]
							ELSIF sel = "000010" THEN
								DATA_BUS_VALUE <= X"11"; -- CH 2[ ]
							ELSIF sel = "000011" THEN
								DATA_BUS_VALUE <= X"11"; -- CH 3[ ]
							ELSIF sel = "000100" THEN
								DATA_BUS_VALUE <= X"11"; -- CH 4[ ]
							ELSIF sel = "000101" THEN
								DATA_BUS_VALUE <= X"11"; -- CH 5[ ]
							ELSIF sel = "000110" THEN
								DATA_BUS_VALUE <= X"11"; -- CH 6[ ]
							ELSIF sel = "000111" THEN
								DATA_BUS_VALUE <= X"11"; -- CH 7[ ]
							ELSIF sel = "001000" THEN
								DATA_BUS_VALUE <= X"11"; -- CH 8[ ]
							ELSIF sel = "001001" THEN
								DATA_BUS_VALUE <= X"11"; -- CH 9[ ]
							ELSIF sel = "001010" THEN
								DATA_BUS_VALUE <= X"11"; -- POWER[ ] 
							ELSIF sel = "001011" THEN
								DATA_BUS_VALUE <= X"11"; -- RADIO[ ]
							ELSIF sel = "001100" THEN
								DATA_BUS_VALUE <= X"11"; -- TV[ ]
							ELSIF sel = "001101" THEN
								DATA_BUS_VALUE <= X"11"; -- MEDIA[ ] 
							ELSIF sel = "001110" THEN
								DATA_BUS_VALUE <= X"11"; -- DVD[ ]
							ELSIF sel = "001111" THEN
								DATA_BUS_VALUE <= X"11"; -- MUSIC[ ]
							ELSIF sel = "010000" THEN
								DATA_BUS_VALUE <= X"11"; -- PICTURE[ ]
							ELSIF sel = "010001" THEN
								DATA_BUS_VALUE <= X"11"; -- VIDEO[ ] 
							ELSIF sel = "010010" THEN
								DATA_BUS_VALUE <= X"11"; -- DVD/MENU[ ] 
							ELSIF sel = "010011" THEN
								DATA_BUS_VALUE <= X"11"; -- UP[ ]
							ELSIF sel = "010100" THEN
								DATA_BUS_VALUE <= X"11"; -- MUTE[ ]
							ELSIF sel = "010101" THEN
								DATA_BUS_VALUE <= X"11"; -- VOL +[ ]
							ELSIF sel = "010110" THEN
								DATA_BUS_VALUE <= X"11"; -- LEFT[ ]
							ELSIF sel = "010111" THEN
								DATA_BUS_VALUE <= X"45"; -- MENU/ENT[E]R
							ELSIF sel = "011000" THEN
								DATA_BUS_VALUE <= X"11"; -- RIGHT[ ]
							ELSIF sel = "011001" THEN
								DATA_BUS_VALUE <= X"11"; -- VOL -[ ]
							ELSIF sel = "011010" THEN
								DATA_BUS_VALUE <= X"11"; -- BACK[ ]
							ELSIF sel = "011011" THEN
								DATA_BUS_VALUE <= X"11"; -- DOWN[ ]
							ELSIF sel = "011100" THEN
								DATA_BUS_VALUE <= X"11"; -- GUIDE[ ]
							ELSIF sel = "011101" THEN
								DATA_BUS_VALUE <= X"11"; -- CH +[ ]
							ELSIF sel = "011110" THEN
								DATA_BUS_VALUE <= X"11"; -- CH -[ ]
							ELSIF sel = "011111" THEN
								DATA_BUS_VALUE <= X"11"; -- REDPOINT[ ]
							ELSIF sel = "100000" THEN
								DATA_BUS_VALUE <= X"11"; -- REPEAT[ ]
							ELSIF sel = "100001" THEN
								DATA_BUS_VALUE <= X"11"; -- PLAY[ ]
							ELSIF sel = "100010" THEN
								DATA_BUS_VALUE <= X"11"; -- PAUSE[ ]
							ELSIF sel = "100011" THEN
								DATA_BUS_VALUE <= X"11"; -- STOP[ ]
							ELSIF sel = "100100" THEN
								DATA_BUS_VALUE <= X"11"; -- <<[ ]
							ELSIF sel = "100101" THEN
								DATA_BUS_VALUE <= X"11"; -- >>[ ]
							ELSIF sel = "100110" THEN
								DATA_BUS_VALUE <= X"11"; -- |<<[ ]
							ELSIF sel = "100111" THEN
								DATA_BUS_VALUE <= X"11"; -- >>| [ ]
							ELSE
								DATA_BUS_VALUE <= X"11"; -- WAIT[ ]
							END IF;
							state <= TOGGLE_E;
							next_command <= WRITE_CHAR10;
					
					WHEN WRITE_CHAR10 =>
							LCD_E <= '1';
							LCD_RS <= '1';
							LCD_RW <= '0';
							IF sel = "000000" THEN
								DATA_BUS_VALUE <= X"11"; -- CH 0[ ] 
							ELSIF sel = "000001" THEN
								DATA_BUS_VALUE <= X"11"; -- CH 1[ ]
							ELSIF sel = "000010" THEN
								DATA_BUS_VALUE <= X"11"; -- CH 2[ ]
							ELSIF sel = "000011" THEN
								DATA_BUS_VALUE <= X"11"; -- CH 3[ ]
							ELSIF sel = "000100" THEN
								DATA_BUS_VALUE <= X"11"; -- CH 4[ ]
							ELSIF sel = "000101" THEN
								DATA_BUS_VALUE <= X"11"; -- CH 5[ ]
							ELSIF sel = "000110" THEN
								DATA_BUS_VALUE <= X"11"; -- CH 6[ ]
							ELSIF sel = "000111" THEN
								DATA_BUS_VALUE <= X"11"; -- CH 7[ ]
							ELSIF sel = "001000" THEN
								DATA_BUS_VALUE <= X"11"; -- CH 8[ ]
							ELSIF sel = "001001" THEN
								DATA_BUS_VALUE <= X"11"; -- CH 9[ ]
							ELSIF sel = "001010" THEN
								DATA_BUS_VALUE <= X"11"; -- POWER[ ] 
							ELSIF sel = "001011" THEN
								DATA_BUS_VALUE <= X"11"; -- RADIO[ ]
							ELSIF sel = "001100" THEN
								DATA_BUS_VALUE <= X"11"; -- TV[ ]
							ELSIF sel = "001101" THEN
								DATA_BUS_VALUE <= X"11"; -- MEDIA[ ] 
							ELSIF sel = "001110" THEN
								DATA_BUS_VALUE <= X"11"; -- DVD[ ]
							ELSIF sel = "001111" THEN
								DATA_BUS_VALUE <= X"11"; -- MUSIC[ ]
							ELSIF sel = "010000" THEN
								DATA_BUS_VALUE <= X"11"; -- PICTURE[ ]
							ELSIF sel = "010001" THEN
								DATA_BUS_VALUE <= X"11"; -- VIDEO[ ] 
							ELSIF sel = "010010" THEN
								DATA_BUS_VALUE <= X"11"; -- DVD/MENU[ ] 
							ELSIF sel = "010011" THEN
								DATA_BUS_VALUE <= X"11"; -- UP[ ]
							ELSIF sel = "010100" THEN
								DATA_BUS_VALUE <= X"11"; -- MUTE[ ]
							ELSIF sel = "010101" THEN
								DATA_BUS_VALUE <= X"11"; -- VOL +[ ]
							ELSIF sel = "010110" THEN
								DATA_BUS_VALUE <= X"11"; -- LEFT[ ]
							ELSIF sel = "010111" THEN
								DATA_BUS_VALUE <= X"52"; -- MENU/ENTE[R]
							ELSIF sel = "011000" THEN
								DATA_BUS_VALUE <= X"11"; -- RIGHT[ ]
							ELSIF sel = "011001" THEN
								DATA_BUS_VALUE <= X"11"; -- VOL -[ ]
							ELSIF sel = "011010" THEN
								DATA_BUS_VALUE <= X"11"; -- BACK[ ]
							ELSIF sel = "011011" THEN
								DATA_BUS_VALUE <= X"11"; -- DOWN[ ]
							ELSIF sel = "011100" THEN
								DATA_BUS_VALUE <= X"11"; -- GUIDE[ ]
							ELSIF sel = "011101" THEN
								DATA_BUS_VALUE <= X"11"; -- CH +[ ]
							ELSIF sel = "011110" THEN
								DATA_BUS_VALUE <= X"11"; -- CH -[ ]
							ELSIF sel = "011111" THEN
								DATA_BUS_VALUE <= X"11"; -- REDPOINT[ ]
							ELSIF sel = "100000" THEN
								DATA_BUS_VALUE <= X"11"; -- REPEAT[ ]
							ELSIF sel = "100001" THEN
								DATA_BUS_VALUE <= X"11"; -- PLAY[ ]
							ELSIF sel = "100010" THEN
								DATA_BUS_VALUE <= X"11"; -- PAUSE[ ]
							ELSIF sel = "100011" THEN
								DATA_BUS_VALUE <= X"11"; -- STOP[ ]
							ELSIF sel = "100100" THEN
								DATA_BUS_VALUE <= X"11"; -- <<[ ]
							ELSIF sel = "100101" THEN
								DATA_BUS_VALUE <= X"11"; -- >>[ ]
							ELSIF sel = "100110" THEN
								DATA_BUS_VALUE <= X"11"; -- |<<[ ]
							ELSIF sel = "100111" THEN
								DATA_BUS_VALUE <= X"11"; -- >>| [ ]
							ELSE
								DATA_BUS_VALUE <= X"11"; -- WAIT[ ]
							END IF;
							state <= TOGGLE_E;
							next_command <= RETURN_HOME;
							
					WHEN RETURN_HOME =>
							LCD_E <= '1';
							LCD_RS <= '0';
							LCD_RW <= '0';
							DATA_BUS_VALUE <= X"80";
							state <= TOGGLE_E;
							next_command <= WRITE_CHAR1;

					WHEN TOGGLE_E =>
							LCD_E <= '0';
							state <= HOLD;
							
					WHEN HOLD =>
							state <= next_command;
				END CASE;
	
		END IF;
		
	END PROCESS;
END a;
