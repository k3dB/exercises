using System;

public class Orm : IDisposable
{
    private bool disposed;
    private Database database;

    public Orm(Database database)
    {
        this.database = database;
    }

    public void Begin()
    {
        try
        {
            database.BeginTransaction();
        }
        catch (InvalidOperationException)
        {
            database.Dispose();
        }
    }

    public void Write(string data)
    {
        try
        {
            database.Write(data);
        }
        catch (InvalidOperationException)
        {
            database.Dispose();
        }
    }

    public void Commit()
    {
        try
        {
            database.EndTransaction();
        }
        catch (InvalidOperationException)
        {
            database.Dispose();
        }
    }

    public void Dispose()
    {
        Dispose(true);
        GC.SuppressFinalize(this);
    }

    protected virtual void Dispose(bool disposing)
    {
        if (disposed)
            return;

        if (disposing)
            database.Dispose();

        disposed = true;
    }
}
