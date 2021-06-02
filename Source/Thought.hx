package;

class Thought {
  public var body: String;
  public var type: String;

  public function new (body: String, type: String = "note") {
    this.body = body;
    this.type = type;
  }
}