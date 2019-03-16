///
module scrapd.assign;

///
void assign(T, U)(ref T target, scope U source)
{
    static foreach (prop; __traits(allMembers, T))
    {
        static if (__traits(compiles, {
                __traits(getMember, target, prop) = __traits(getMember, source, prop);
            }))
        {
            __traits(getMember, target, prop) = __traits(getMember, source, prop);
        }
    }
}

///
unittest
{
    struct A
    {
        int x;
        int y;
    }
    struct B
    {
        int x;
        float z;
    }

    A a = { x: 10, y: 20 };
    B b = { x: 1, z: 1.0f };
    assign(a, b);

    assert(a.x == 1);
}

unittest
{
    struct A
    {
        float x;
        int y;
    }
    struct B
    {
        int x;
        float y;
    }

    A a = { x: 10.0f, y: 20 };
    B b = { x: 1, y: 1.0f };
    assign(a, b);

    assert(a.x == 1.0f);
    assert(a.y == 20); // non compatible types
}
