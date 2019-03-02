# scrapd

Some minimum utilities.

### let

```d
import scrapd.let;

struct User
{
    string id;
    string name;
}

void main()
{
    auto user = User().let!((ref u) => u.id = "dummy");

    writeln(user.id); // dummy
}
```