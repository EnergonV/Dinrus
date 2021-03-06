// D import file generated from 'src\core\sync\mutex.d'
module core.sync.mutex;
public import core.sync.exception;

version (Windows)
{
	private import core.sys.windows.windows;

}
else
{
	version (Posix)
	{
		private import core.sys.posix.pthread;

	}
	else
	{
		static assert(false, "Platform not supported");
	}
}
class Mutex : Object.Monitor
{
	this();
	this(Object o);
	~this();
	@trusted void lock();

	@trusted void unlock();

	bool tryLock();
	private 
	{
		version (Windows)
		{
			CRITICAL_SECTION m_hndl;
		}
		else
		{
			version (Posix)
			{
				pthread_mutex_t m_hndl;
			}
		}
		struct MonitorProxy
		{
			Object.Monitor link;
		}
		MonitorProxy m_proxy;
		package version (Posix)
		{
			pthread_mutex_t* handleAddr();
		}

	}
}
version (unittest)
{
	private import core.thread;

}
