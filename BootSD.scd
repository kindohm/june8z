s.options.device_("MME : Line 1 (Virtual Audio Cable)");

(
// configure the sound server: here you could add hardware specific options
// see http://doc.sccode.org/Classes/ServerOptions.html
s.options.numBuffers = 1024 * 16; // increase this if you need to load more samples
s.options.memSize = 8192 * 16; // increase this if you get "alloc failed" messages
s.options.maxNodes = 1024 * 32; // increase this if you are getting drop outs and the message "too many nodes"
s.options.numOutputBusChannels = 2; // set this to your hardware output channel size, if necessary

// boot the server and start SuperDirt
s.waitForBoot {
	~dirt = SuperDirt(2, s); // two output channels, increase if you want to pan across more channels
	~dirt.loadSoundFiles("C:\\Users\\kindohm\\studio\\tidal-samples\\tracks\\8z\\*");
	~dirt.loadSoundFiles("C:\\Users\\kindohm\\studio\\tidal-samples\\tracks\\friend-suggestion\\*");
	~dirt.loadSoundFiles("C:\\Users\\kindohm\\studio\\tidal-samples\\tracks\\rebellion\\*");
	~dirt.loadSoundFiles("C:\\Users\\kindohm\\studio\\tidal-samples\\tracks\\like-mining\\*");
	~dirt.loadSoundFiles("C:\\Users\\kindohm\\studio\\tidal-samples\\tracks\\shared\\*");
	s.sync; // wait for samples to be read
	~dirt.start(57120, [0, 0]);   // start listening on port 57120, create two busses each sending audio to channel 0
};

s.latency = 0.2; // increase this if you get "late" messages
);

(
MIDIClient.init;
MIDIClient.list; // to check, which are there, you can query them
)

~midiOut = MIDIOut.newByName("Focusrite USB MIDI", "Focusrite USB MIDI"); // substitute your own device here
~midiOut.latency = 0.45;
~dirt.soundLibrary.addMIDI(\midi, ~midiOut);

