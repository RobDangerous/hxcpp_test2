package;

import haxe.format.JsonParser;
import kha.Assets;
import kha.Framebuffer;
import kha.Scheduler;
import kha.System;

class Main {
	static var arr: Array<Dynamic> = [];

	static function readFile() {
		arr.push(JsonParser.parse(Assets.blobs.large_file_json.toString()));
		while (arr.length > 20) {
			arr.remove(arr[0]);
		}
	}
	
	static function update(): Void {

	}

	static function render(framebuffer: Framebuffer): Void {

	}

	public static function main() {
		System.start({title: "Kha", width: 800, height: 600}, function (_) {
			// Just loading everything is ok for small projects
			Assets.loadEverything(function () {
				for (i in 0...1000) {
					trace("Reading file " + i);
					readFile();
				}
				trace("Done");
				// Avoid passing update/render directly,
				// so replacing them via code injection works
				Scheduler.addTimeTask(function () { update(); }, 0, 1 / 60);
				System.notifyOnFrames(function (framebuffers) { render(framebuffers[0]); });
			});
		});
	}
}
