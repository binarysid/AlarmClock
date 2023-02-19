
import CoreData

struct PersistenceService{
    static var ContainerName = "Model_V1"
    enum Context{
        case Main(NSManagedObjectContext)
        case Background(NSManagedObjectContext)
        typealias type = NSManagedObjectContext
        
        var value:NSManagedObjectContext{
            switch self {
            case .Main(let context):
                return context
            case .Background(let context):
                return context
            }
        }
    }
    indirect enum Error: RepositoryError {
        case NoDataFound
        case InvalidManagedObjectType
        case ServiceNotAvailable
        case FailedToSave
        case FailedToDelete
        case DataHandlingError
        
        var noData: PersistenceService.Error{
            .NoDataFound
        }
        var noService: PersistenceService.Error{
            .ServiceNotAvailable
        }
        var errorDescription: String {
            switch self {
            case .ServiceNotAvailable: return "Service unreachable"
            case .NoDataFound: return "No data found"
            case .InvalidManagedObjectType:  return "Something went wrong"
            case .FailedToSave:
                return "Failed to save data"
            case .FailedToDelete:
                return "Item deletion failed"
            case .DataHandlingError:
                return "Error while handling data"
            }
        }
    }
    
    enum Entity{
        enum AlarmList{
            typealias RequestType = NSFetchRequest<Alarm>
            static var FetchRequest:NSFetchRequest<Alarm>{
                Alarm.fetchRequest()
            }
        }
    }
}
