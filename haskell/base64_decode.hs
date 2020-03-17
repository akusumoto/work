import Data.Bits
import qualified Data.Map as Map
import Data.Char

-- 0	000000	A		16	010000	Q		32	100000	g		48	110000	w
-- 1	000001	B		17	010001	R		33	100001	h		49	110001	x
-- 2	000010	C		18	010010	S		34	100010	i		50	110010	y
-- 3	000011	D		19	010011	T		35	100011	j		51	110011	z
-- 4	000100	E		20	010100	U		36	100100	k		52	110100	0
-- 5	000101	F		21	010101	V		37	100101	l		53	110101	1
-- 6	000110	G		22	010110	W		38	100110	m		54	110110	2
-- 7	000111	H		23	010111	X		39	100111	n		55	110111	3
-- 8	001000	I		24	011000	Y		40	101000	o		56	111000	4
-- 9	001001	J		25	011001	Z		41	101001	p		57	111001	5
-- 10	001010	K		26	011010	a		42	101010	q		58	111010	6
-- 11	001011	L		27	011011	b		43	101011	r		59	111011	7
-- 12	001100	M		28	011100	c		44	101100	s		60	111100	8
-- 13	001101	N		29	011101	d		45	101101	t		61	111101	9
-- 14	001110	O		30	011110	e		46	101110	u		62	111110	+
-- 15	001111	P		31	011111	f		47	101111	v		63	111111	/

decodeMap = Map.fromList $ zip "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/" [0 ..]
{-
decodeMap = Map.fromList [ ('A', 0x00 ), ('B', 0x01 ), ('C', 0x02 ), ('D', 0x03 ),
                       ('E', 0x04 ), ('F', 0x05 ), ('G', 0x06 ), ('H', 0x07 ),
                       ('I', 0x08 ), ('J', 0x09 ), ('K', 0x0A ), ('L', 0x0B ),
                       ('M', 0x0C ), ('N', 0x0D ), ('O', 0x0E ), ('P', 0x0F ),
                       ('Q', 0x10 ), ('R', 0x11 ), ('S', 0x12 ), ('T', 0x13 ),
                       ('U', 0x14 ), ('V', 0x15 ), ('W', 0x16 ), ('X', 0x17 ),
                       ('Y', 0x18 ), ('Z', 0x19 ),
                       ('a', 0x1A ), ('b', 0x1B ), ('c', 0x1C ), ('d', 0x1D ),
                       ('e', 0x1E ), ('f', 0x1F ), ('g', 0x20 ), ('h', 0x21 ),
                       ('i', 0x22 ), ('j', 0x23 ), ('k', 0x24 ), ('l', 0x25 ),
                       ('m', 0x26 ), ('n', 0x27 ), ('o', 0x28 ), ('p', 0x29 ),
                       ('q', 0x2A ), ('r', 0x2B ), ('s', 0x2C ), ('t', 0x2D ),
                       ('u', 0x2E ), ('v', 0x2F ), ('w', 0x30 ), ('x', 0x31 ),
                       ('y', 0x32 ), ('z', 0x33 ),
                       ('0', 0x34 ), ('1', 0x35 ), ('2', 0x36 ), ('3', 0x37 ),
                       ('4', 0x38 ), ('5', 0x39 ), ('6', 0x3A ), ('7', 0x3B ),
                       ('8', 0x3C ), ('9', 0x3D ), 
                       ('+', 0x3E ), ('9', 0x3F ) ]
-}

getDecodeValue :: Char -> Maybe Int
getDecodeValue c = Map.lookup c decodeMap 

strToIntList :: [Char] -> [Int]
strToIntList [] = []
strToIntList (e:eword) = v:(strToIntList eword)
    where 
        v = case getDecodeValue e of
                Just v  -> v
                Nothing -> 0

intListToStr :: [Int] -> [Char]
intListToStr list = [a, b, c]
    where
        a1 = (list !! 0) .&. 0x3F
        a2 = (list !! 1) .&. 0x30
        b1 = (list !! 1) .&. 0x0F
        b2 = (list !! 2) .&. 0x3C
        c1 = (list !! 2) .&. 0x03
        c2 = (list !! 3) .&. 0x3F
        a = chr $ ((shiftL a1 2) + (shiftR a2 4))
        b = chr $ ((shiftL b1 4) + (shiftR b2 2))
        c = chr $ ((shiftL c1 6) + c2)

decode' = intListToStr . strToIntList

decode :: String -> String
decode [] = []
decode enc = decode' fst ++ decode snd
    where 
        fst = take 4 enc
        snd = drop 4 enc

main = do
    enc <- getLine
    putStr $ decode enc
