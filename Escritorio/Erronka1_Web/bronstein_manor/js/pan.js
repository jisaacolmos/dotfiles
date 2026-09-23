const container = document.getElementById('pan-mobile-container');

let isDragging = false;
let startX, startY;
let startBgX = 0, startBgY = 0;

let minX = 0, minY = 0;

function updateBoundaries() {
    const img = new Image();
    const bgImgUrl = window.getComputedStyle(container).backgroundImage.slice(5, -2);
    img.src = bgImgUrl;

    img.onload = function () {
        const containerWidth = container.clientWidth;
        const containerHeight = container.clientHeight;

        const containerRatio = containerWidth / containerHeight;
        const imageRatio = img.width / img.height;

        let renderedWidth, renderedHeight;

        if (containerRatio > imageRatio) {
            renderedWidth = containerWidth;
            renderedHeight = containerWidth / imageRatio;
        } else {
            renderedWidth = containerHeight * imageRatio;
            renderedHeight = containerHeight;
        }

        minX = containerWidth - renderedWidth;
        minY = containerHeight - renderedHeight;
    };
}

window.addEventListener('load', updateBoundaries);
window.addEventListener('resize', updateBoundaries);

container.addEventListener('mousedown', (e) => {
    isDragging = true;

    startX = e.clientX;
    startY = e.clientY;

    const computedStyle = window.getComputedStyle(container);
    const bgPos = computedStyle.backgroundPosition.split(' ');

    startBgX = parseInt(bgPos[0]) || 0;
    startBgY = parseInt(bgPos[1]) || 0;

    e.preventDefault();
});

window.addEventListener('mousemove', (e) => {
    if (!isDragging) return;

    const deltaX = e.clientX - startX;
    const deltaY = e.clientY - startY;

    let targetX = startBgX + deltaX;
    let targetY = startBgY + deltaY;

    targetX = Math.max(minX, Math.min(0, targetX));
    targetY = Math.max(minY, Math.min(0, targetY));

    container.style.backgroundPosition = `${targetX}px ${targetY}px`;
});

window.addEventListener('mouseup', () => {
    isDragging = false;
});
