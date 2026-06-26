library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity alu4 is
    Port (
        A     : in  STD_LOGIC_VECTOR(3 downto 0);
        B     : in  STD_LOGIC_VECTOR(3 downto 0);
        sel   : in  STD_LOGIC_VECTOR(2 downto 0);
        Y     : out STD_LOGIC_VECTOR(3 downto 0);
        carry : out STD_LOGIC;
        zero  : out STD_LOGIC
    );
end alu4;

architecture Behavioral of alu4 is
    signal y_temp : STD_LOGIC_VECTOR(3 downto 0);
begin

    process(A, B, sel)
        variable result : unsigned(4 downto 0);
    begin
        carry <= '0';
        y_temp <= "0000";
        result := (others => '0');

        case sel is
            when "000" =>
                result := ('0' & unsigned(A)) + ('0' & unsigned(B));
                y_temp <= std_logic_vector(result(3 downto 0));
                carry <= result(4);

            when "001" =>
                y_temp <= std_logic_vector(unsigned(A) - unsigned(B));

            when "010" =>
                y_temp <= A and B;

            when "011" =>
                y_temp <= A or B;

            when "100" =>
                y_temp <= A xor B;

            when "101" =>
                y_temp <= not A;

            when "110" =>
                if unsigned(A) > unsigned(B) then
                    y_temp <= "0001";
                else
                    y_temp <= "0000";
                end if;

            when "111" =>
                y_temp <= A;

            when others =>
                y_temp <= "0000";
        end case;
    end process;

    Y <= y_temp;
    zero <= '1' when y_temp = "0000" else '0';

end Behavioral;
