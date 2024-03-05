#include <cstdint> 
#include <iostream> 
#include <exception> 

constexpr std::uint32_t AddU8(std::uint32_t a, std::uint32_t b)
{
    if ((a + b) >= 256)
    {
        throw std::exception{};
    }

    return a + b;
}

constexpr std::uint32_t DoubleU8(std::uint32_t n)
{
    try
    {
        return AddU8(n, n);
    }
    catch (const std::exception& except)
    {
        return 0;
    }
}

int main()
{
    static_assert(DoubleU8(123) == 246); // OK: 例外を投げずに定数式として評価可能

    //static_assert(DoubleU8(200) > 0); // コンパイルエラー: 定数式として評価される constexpr 関数内で例外を投げるため

    std::cout << "result: " << DoubleU8(200) << '\n'; // OK: 実行時に評価される関数で例外が発生する
}
