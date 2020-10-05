let imageFilename = '/cloudstorage/annotation-studio/data/' + msg._msgid + '.jpg';
let taskFilename = '/cloudstorage/annotation-studio/tasks/' + msg._msgid + '.json';

let imageBase64 = msg.payload.event.image.split(",")[1]
let imageBuffer = Buffer.from(imageBase64, 'base64');


let task = {
    data: {
        image: imageFilename.substring(1)
    }
}

function toPredictions(objects) {
    let result = [];
    for (let i = 0; i < objects.length; i++) {
        let object = objects[i];
        let prediction = {
            model: "change_me_later",
            from_name: "label",
            source: "$image",
            to_name: "image",
            type: "rectanglelabels",
            value: {
                score: object.score,
                rectanglelabels: [
                    object.className
                ],
                rotation: 0,
                x: object.bbox[0] * 100.0,
                y: object.bbox[1] * 100.0,
                width: object.bbox[2] * 100.0,
                height: object.bbox[3] * 100.0
            }
        };
        result.push(prediction);
    }
    return { result: result };
}

if (msg.payload.event.objects) {
    task["predictions"] = [];
    task["predictions"].push(toPredictions(msg.payload.event.objects));
}

return [
    {
        filename: imageFilename,
        payload: imageBuffer
    },
    {
        filename: taskFilename,
        payload: task
    }
];
