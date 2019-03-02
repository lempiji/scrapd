///
module scrapd.let;

/// 
template let(alias fun)
{
    auto ref T let(T)(auto ref T obj)
    {
        fun(obj);
        return obj;
    }
}

///
unittest
{
    struct Test
    {
        string name;
        int age;
    }

    auto test = Test().let!((ref test) => test.name = "A");
    assert(test.name == "A");
}

///
unittest
{
    struct Test
    {
        string name;
        int age;
    }

    auto test = Test().let!((ref test) => test.age = 10);
    assert(test.age == 10);
}

///
unittest
{
    struct Test
    {
        string name;
        int age;
    }

    auto test = Test().let!((ref test) { test.name = "TEST"; test.age = 10; });
    assert(test.name == "TEST");
    assert(test.age == 10);
}

unittest
{
    struct Test
    {
        string name;
    }

    alias withName = (ref obj) { obj.name = "TEST"; };

    auto test = Test().let!withName;
    assert(test.name == "TEST");
}

unittest
{
    import std.algorithm : move;

    struct Test
    {
        string name;
    }

    Test test;
    test = move(test).let!((ref obj) { obj.name = "TEST"; });
    assert(test.name == "TEST");
}

unittest
{
    import std.algorithm : move;

    struct Test
    {
        string name;
    }

    alias withName = (ref obj) { obj.name = "TEST"; };

    Test test;
    test = move(test).let!withName;
    assert(test.name == "TEST");
}
